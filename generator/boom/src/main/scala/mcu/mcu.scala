//jd+begin
package boom.mcu

import chisel3._
import chisel3.util._

import freechips.rocketchip.config.Parameters
import freechips.rocketchip.rocket
import freechips.rocketchip.tilelink._
import freechips.rocketchip.util.Str

import boom.common._
import boom.exu.{BrResolutionInfo, Exception, FuncUnitResp, CommitSignals, ExeUnitResp}
import boom.util.{BoolToChar, AgePriorityEncoder, IsKilledByBranch, GetNewBrMask, WrapInc, IsOlder, UpdateBrMask}

class MCU(implicit p: Parameters) extends BoomBUndle()(p)
{
  //initialize variables
  val valid = Bool()
  val type = Bool() //hardcoded to False for now since not concered w l/s FSM rn (so l/s === True while bndstr === False)
  val addr = UInt(coreMaxAddrBits.W)
  val bnddata = UInt(8.W) //hardcoded to be 8 for 8-bytes
  val bndaddr = UInt(coreMaxAddrBits.W)
  val way = UInt(32.W) //unsure of max ways to access a row
  val count = UInt(32.W) //hardcoded for now
  val committed = Bool()
  val init :: occcheck :: bndchk :: bndstr :: inccnt :: fail :: done :: Nil = Enum(7)
  val state = WireDefault(init)
  //unsure how this is going to be linked to everything else - maybe put FSM right in here?

  when (state === init) { //need to actually connect signed/srcregready info, not correct rn - not sure where ready is from
    //means value from src reg is read (?) so pretend 
    when (io.type && signed && srcregready) { state := bndchk }
    when (io.type && !signed) {state := done}
    when (!io.type && srcregready) {state := occcheck}
  }
  when (state === occcheck) {
    when (io.succeed) { state := bndstr }
    when (!io.succeed){ state := inccnt }
  }
  when (state === bndchk) {
    when (io.succeed) { state := done}
    when (!io.succeed)   { state := inccnt }
  }
  when (state === bndstr) {
    when (io.committed) {state := done}
  }
  when (state === inccnt) {
    when (io.count < io.ways && io.type) {state := bndchk }
    when (io.count < io.ways && !io.type) {state := occcheck }
    when (io.count === io.ways) {state := fail}
  }
  when (state === fail) { state := fail } //just keeping these in this state
  when (state === done) { state := done }

}
//jd+end
