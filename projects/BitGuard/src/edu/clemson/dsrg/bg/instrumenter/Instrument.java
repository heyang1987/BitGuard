/**
 * 
 */
package edu.clemson.dsrg.bg.instrumenter;
/**
 * @author Heyang
 *
 */
import java.io.File;
import org.squirrelframework.foundation.fsm.StateMachine;
import org.squirrelframework.foundation.fsm.StateMachineBuilder;
import org.squirrelframework.foundation.fsm.StateMachineBuilderFactory;
import org.squirrelframework.foundation.fsm.StateMachine.TransitionCompleteEvent;

import edu.clemson.dsrg.bg.*;
import edu.clemson.dsrg.bg.instrumenter.InstrumentController;
import edu.clemson.dsrg.bg.instrumenter.InstrumentController.InstrumentEvent;
import edu.clemson.dsrg.bg.instrumenter.InstrumentController.InstrumentState;

public class Instrument {
	private static Instrument instance = null;
	
	protected Instrument() {
	      // Exists only to defeat instantiation.
	}
	
   	public static Instrument getInstance() {
   		if(instance == null) {
   			instance = new Instrument();
   		}
   		return instance;
   	}

   	public static void main(String[] args){
   		StateMachineBuilder<InstrumentController, InstrumentState, InstrumentEvent, InstrumentContext> builder = 
   				StateMachineBuilderFactory.create(
                		InstrumentController.class,
                		InstrumentState.class, 
                		InstrumentEvent.class, 
                		InstrumentContext.class
                );
   		InstrumentController controller = builder.newStateMachine(InstrumentState.INIT);
   		final InstrumentAnalyzer analyzer = new InstrumentAnalyzer(controller);
   		analyzer.startAnalyze();
   	}
   	
}
