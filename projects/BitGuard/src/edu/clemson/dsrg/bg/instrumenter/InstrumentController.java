/**
 * 
 */
package edu.clemson.dsrg.bg.instrumenter;
/**
 * @author yang
 *
 */
import java.util.Map;

import org.squirrelframework.foundation.fsm.Condition;
import org.squirrelframework.foundation.fsm.ImmutableState;
import org.squirrelframework.foundation.fsm.annotation.State;
import org.squirrelframework.foundation.fsm.annotation.States;
import org.squirrelframework.foundation.fsm.annotation.Transit;
import org.squirrelframework.foundation.fsm.annotation.Transitions;
import org.squirrelframework.foundation.fsm.impl.AbstractStateMachine;
//import org.squirrelframework.foundation.fsm.impl.AbstractStateMachineWithoutContext;

import edu.clemson.dsrg.bg.instrumenter.InstrumentController.InstrumentState;
import edu.clemson.dsrg.bg.instrumenter.InstrumentController.InstrumentEvent;
import edu.clemson.dsrg.bg.instrumenter.InstrumentContext;

@States({
	@State(name="INIT",initialState=true),
	@State(name="BACKUP_REG"),
	@State(name="CHANGE_STACK"),
	@State(name="PROGRAM"),
	@State(name="RECOVER_STACK"),
	@State(name="RECOVER_REG"),
	@State(name="DONE")
})
@Transitions({
	@Transit(from = "INIT", to = "INIT", on = "MOVE_AHEAD", callMethod = ""),
	@Transit(from = "INIT", to = "BACKUP_REG", on = "INIT_TO_BACKUP_REG", callMethod = ""),
	
	@Transit(from = "BACKUP_REG", to = "BACKUP_REG", on = "MOVE_AHEAD", callMethod = ""),
	@Transit(from = "BACKUP_REG", to = "CHANGE_STACK", on = "BACKUP_REG_TO_CHANGE_STACK", callMethod = ""),
	@Transit(from = "BACKUP_REG", to = "PROGRAM", on = "BACKUP_REG_TO_PROGRAM", callMethod = ""),
	
	@Transit(from = "CHANGE_STACK", to = "CHANGE_STACK", on = "MOVE_AHEAD", callMethod = ""),
	@Transit(from = "CHANGE_STACK", to = "PROGRAM", on = "CHANGE_STACK_TO_PROGRAM", callMethod = ""),
	
	@Transit(from = "PROGRAM", to = "PROGRAM", on = "MOVE_AHEAD", callMethod = ""),
	@Transit(from = "PROGRAM", to = "RECOVER_STACK", on = "PROGRAM_TO_RECOVER_STACK", callMethod = ""),
	@Transit(from = "PROGRAM", to = "RECOVER_REG", on = "PROGRAM_TO_RECOVER_REG", callMethod = ""),
	@Transit(from = "PROGRAM", to = "DONE", on = "PROGRAM_TO_DONE", callMethod = ""),
	
	@Transit(from = "RECOVER_STACK", to = "RECOVER_STACK", on = "MOVE_AHEAD", callMethod = ""),
	@Transit(from = "RECOVER_STACK", to = "RECOVER_REG", on = "RECOVER_STACK_TO_RECOVER_REG", callMethod = ""),
	
	@Transit(from = "RECOVER_REG", to = "RECOVER_REG", on = "MOVE_AHEAD", callMethod = ""),
	@Transit(from = "RECOVER_REG", to = "PROGRAM", on = "RECOVER_REG_TO_PROGRAM", callMethod = ""),
	
	@Transit(from = "DONE", to = "DONE", on = "MOVE_AHEAD", callMethod = ""),
	@Transit(from = "DONE", to = "BACKUP_REG", on = "DONE_TO_BACKUP_REG", callMethod = "")
	
})

public class InstrumentController extends AbstractStateMachine<InstrumentController, InstrumentState, InstrumentEvent, InstrumentContext> {

	public enum InstrumentState {
		INIT,
		BACKUP_REG,
		CHANGE_STACK,
		PROGRAM,
		RECOVER_STACK,
		RECOVER_REG,
		DONE
	}
	
	public enum InstrumentEvent {
		MOVE_AHEAD,
		INIT_TO_BACKUP_REG,
		BACKUP_REG_TO_CHANGE_STACK,
		BACKUP_REG_TO_PROGRAM,
		CHANGE_STACK_TO_PROGRAM,
		PROGRAM_TO_RECOVER_STACK,
		PROGRAM_TO_RECOVER_REG,
		RECOVER_STACK_TO_RECOVER_REG,
		RECOVER_REG_TO_PROGRAM,
		PROGRAM_TO_DONE,
		DONE_TO_BACKUP_REG
	}
	
	public static class ContinueRunningCondition implements Condition<InstrumentContext> {
		@Override
        public boolean isSatisfied(InstrumentContext context) {
			return false;
        }
	}
	
    protected InstrumentController(
            ImmutableState<InstrumentController, InstrumentState, InstrumentEvent, InstrumentContext> initialState,
            Map<InstrumentState, ImmutableState<InstrumentController, InstrumentState, InstrumentEvent, InstrumentContext>> states) {
        super(initialState, states);
    }
    
    public void onSBIW(InstrumentState from, InstrumentState to, InstrumentEvent event, InstrumentContext context) {
    	//TODO
    	//System.out.println(to);
    }
    
    public void onGoToProgram(InstrumentState from, InstrumentState to, InstrumentEvent event, InstrumentContext context) {
    	//TODO
    	//System.out.println(to);
    }
    /*
     * Unit Test
     */
    /*
   	public void main(String[] args){
   		InstrumentContext instrumentContext = null;
   		onSBIW(InstrumentState.MAIN_BACKUP_REG, InstrumentState.MAIN_CHANGE_STACK,InstrumentEvent.SBIW,instrumentContext);
   	}
	*/
}


