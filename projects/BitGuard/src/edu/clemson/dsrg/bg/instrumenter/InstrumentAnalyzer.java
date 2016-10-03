/**
 * 
 */
package edu.clemson.dsrg.bg.instrumenter;

import java.util.*;

import org.omg.CORBA.PUBLIC_MEMBER;

import edu.clemson.dsrg.bg.instrumenter.InstrumentController;
import edu.clemson.dsrg.bg.instrumenter.InstrumentController.InstrumentEvent;
import edu.clemson.dsrg.bg.instrumenter.InstrumentController.InstrumentState;
import edu.clemson.dsrg.bg.scanner.*;
import edu.clemson.dsrg.bg.bean.AssemblyNodeBean;
import edu.clemson.dsrg.bg.definition.*;

/**
 * @author yang
 *
 */
public class InstrumentAnalyzer {
	private InstrumentController analyzerController;
	private InstrumentContext NodeList = new InstrumentContext();
	
	public InstrumentAnalyzer(InstrumentController controller) {
		this.analyzerController = controller;
		//TODO
	}
	
	public void startAnalyze() {
		
		ScannerReader.createFileList();
		for(Map.Entry<String, List<AssemblyNodeBean> > entry : AssemblyDefinition.beanHashMap.entrySet()){
			String key = entry.getKey();
			System.out.println(key+":");
			List<AssemblyNodeBean> beanlist = entry.getValue();
			for(AssemblyNodeBean bean: beanlist){
				//System.out.println("**bean type: "+bean.getType()+bean.getKeyword()+" "+bean.getOperand1()+" "+bean.getOperand2()+" "+bean.getOperand3());
				
				System.out.println("**bean type: "+bean.getType()
									+"   keyword: "+bean.getKeyword()
									+"   operand1: "+bean.getOperand1()
									+"   operand2: "+bean.getOperand2()
									+"   operand3: "+bean.getOperand3()+"**");
									
				System.out.println(analyzerController.getCurrentState());
				//System.out.println(AssemblyDefinition.ASM_REGISTER_R28_FLAG);
				//System.out.println(AssemblyDefinition.ASM_REGISTER_R29_FLAG);
				// State: INIT to BACKUP_REG
				if( analyzerController.getCurrentState().equals(InstrumentState.INIT) && 
						bean.getKeyword().equals(AssemblyDefinition.ASM_DIRECTIVE_GLOBAL) &&
						bean.getOperand1().equals(AssemblyDefinition.ASM_KEYWORD_MAIN)){
					//System.out.println("INIT_TO_BACKUP_REG");
					analyzerController.fire(InstrumentEvent.INIT_TO_BACKUP_REG, NodeList);
					//System.out.println("The State has been set to: "+analyzerController.getCurrentState());
				}
				// State: BACKUP_REG to CHANGE_STACK
				else if( analyzerController.getCurrentState().equals(InstrumentState.BACKUP_REG) && 
						bean.getKeyword().equals(AssemblyDefinition.ASM_INSTRUCTION_SBIW) ){
					//System.out.println("BACKUP_REG_TO_CHANGE_STACK");
					analyzerController.fire(InstrumentEvent.BACKUP_REG_TO_CHANGE_STACK, NodeList);
					//System.out.println("The State has been set to: "+analyzerController.getCurrentState());
				}
				// State: BACKUP_REG to PROGRAM
				else if ( analyzerController.getCurrentState().equals(InstrumentState.BACKUP_REG) && 
						bean.getKeyword().equals(AssemblyDefinition.ASM_INSTRUCTION_OUT) &&
						bean.getOperand2().equals(AssemblyDefinition.ASM_REGISTER_R29) ){
					if (!AssemblyDefinition.ASM_REGISTER_R28_FLAG) {
						AssemblyDefinition.ASM_REGISTER_R29_FLAG = true;
						
					}
					else {
						//System.out.println("BACKUP_REG_TO_PROGRAM");
						analyzerController.fire(InstrumentEvent.BACKUP_REG_TO_PROGRAM, NodeList);
						//System.out.println("The State has been set to: "+analyzerController.getCurrentState());
						AssemblyDefinition.ASM_REGISTER_R28_FLAG = false;
					}
				}
				else if ( analyzerController.getCurrentState().equals(InstrumentState.BACKUP_REG) && 
						bean.getKeyword().equals(AssemblyDefinition.ASM_INSTRUCTION_OUT) &&
						bean.getOperand2().equals(AssemblyDefinition.ASM_REGISTER_R28) ){
					if (!AssemblyDefinition.ASM_REGISTER_R29_FLAG) {
						AssemblyDefinition.ASM_REGISTER_R29_FLAG = true;
					}
					else {
						//System.out.println("BACKUP_REG_TO_PROGRAM");
						analyzerController.fire(InstrumentEvent.BACKUP_REG_TO_PROGRAM, NodeList);
						//System.out.println("The State has been set to: "+analyzerController.getCurrentState());
						AssemblyDefinition.ASM_REGISTER_R29_FLAG = false;
					}
				}
				// State: CHANGE_STACK to PROGRAM
				else if ( analyzerController.getCurrentState().equals(InstrumentState.CHANGE_STACK) && 
						bean.getKeyword().equals(AssemblyDefinition.ASM_INSTRUCTION_OUT) &&
						bean.getOperand2().equals(AssemblyDefinition.ASM_REGISTER_R29) ){
					if (!AssemblyDefinition.ASM_REGISTER_R28_FLAG) {
						AssemblyDefinition.ASM_REGISTER_R29_FLAG = true;
						
					}
					else {
						//System.out.println("CHANGE_STACK_TO_PROGRAM");
						analyzerController.fire(InstrumentEvent.CHANGE_STACK_TO_PROGRAM, NodeList);
						//System.out.println("The State has been set to: "+analyzerController.getCurrentState());
						AssemblyDefinition.ASM_REGISTER_R28_FLAG = false;
					}
				}
				else if ( analyzerController.getCurrentState().equals(InstrumentState.CHANGE_STACK) && 
						bean.getKeyword().equals(AssemblyDefinition.ASM_INSTRUCTION_OUT) &&
						bean.getOperand2().equals(AssemblyDefinition.ASM_REGISTER_R28) ){
					if (!AssemblyDefinition.ASM_REGISTER_R29_FLAG) {
						AssemblyDefinition.ASM_REGISTER_R29_FLAG = true;
					}
					else {
						//System.out.println("CHANGE_STACK_TO_PROGRAM");
						analyzerController.fire(InstrumentEvent.CHANGE_STACK_TO_PROGRAM, NodeList);
						//System.out.println("The State has been set to: "+analyzerController.getCurrentState());
						AssemblyDefinition.ASM_REGISTER_R29_FLAG = false;
					}
				}
				// State: PROGRAM to DONE
				else if ( analyzerController.getCurrentState().equals(InstrumentState.PROGRAM) && 
						bean.getKeyword().equals(AssemblyDefinition.ASM_DIRECTIVE_SIZE) ){
					//System.out.println("PROGRAM_TO_DONE");
					analyzerController.fire(InstrumentEvent.PROGRAM_TO_DONE, NodeList);
					//System.out.println("The State has been set to: "+analyzerController.getCurrentState());
				}
				// State: DONE to BACKUP_REG
				else if ( analyzerController.getCurrentState().equals(InstrumentState.DONE) && 
						bean.getKeyword().equals(AssemblyDefinition.ASM_DIRECTIVE_GLOBAL) ){
					//System.out.println("DONE_TO_BACKUP_REG");
					analyzerController.fire(InstrumentEvent.DONE_TO_BACKUP_REG, NodeList);
					//System.out.println("The State has been set to: "+analyzerController.getCurrentState());
				}
				
			}
		}
	} 
}
