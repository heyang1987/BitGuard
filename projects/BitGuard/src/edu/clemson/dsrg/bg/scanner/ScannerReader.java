package edu.clemson.dsrg.bg.scanner;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import  java.util.List;
import java.util.Map;

import edu.clemson.dsrg.bg.bean.AssemblyNodeBean;
import edu.clemson.dsrg.bg.definition.*;
/**
 * 
 * @author yuheng
 *
 */


public class ScannerReader {
	
	/**
	 * create the a linkedlist of AssemblyNodeBean for each .s file under given directory
	 * store the list in beanHashMap as value 
	 * .s file name as the key
	 */
	public static void createFileList(){
		String directory =AssemblyDefinition.DIRECTORY;
		File f = new File(directory);
		File [] asmfiles = f.listFiles();
		
		
		List<File> asmfilelist = new ArrayList<File>();
		for(File asmfile: asmfiles){
			AssemblyDefinition.asmFileList.add(asmfile);
			/*one linked list of node beans for each asmfile*/
			List<AssemblyNodeBean> beanlist = new LinkedList<AssemblyNodeBean>();
			
			//System.out.println(asmfile.getAbsolutePath());
			BufferedReader reader = null;
			int line = 1;
			try {
				reader = new BufferedReader(new FileReader(asmfile));
				String commandString = null;
				while ((commandString = reader.readLine())!=null){
					/*call the create bean function*/
					AssemblyNodeBean bean = createBean(commandString);
					
					if (bean == null){
						/*bean corresponding to comment line or empty line*/
						//System.out.println("line "+line+": "+commandString+ " ***bean type: comment / empty***");
					}
					else {
						/* link the bean into linked list*/
						beanlist.add(bean);
						//if(bean.getType().toString().equals("directive")){
						/*
						System.out.println("line "+line+": "+commandString+ " ***bean type: "+ bean.getType().toString()
														+"   keyword: "+ bean.getKeyword()
														+"   operand1: "+bean.getOperand1()
														+"   operand2: "+bean.getOperand2()
														+"   operand3: "+bean.getOperand3()+ "***");
						 */
						//System.out.println("line "+line+": "+commandString+ " ***bean type: noempty***");
						//}
					}
					
					++line; 
				}
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				if(reader !=null){
					try{
						reader.close();
					}catch(IOException e1){
						// do nothing}
					}
				}
			}	
			// update the node map for each asm file
			AssemblyDefinition.beanHashMap.put(asmfile.getName(), beanlist);
			
		}
		
	}
	
	/**
	 * create assemblynodebean with given line of command
	 * @param command
	 * @return return null if a comment line or empty line was processed
	 */
	public static AssemblyNodeBean createBean(String command){
		AssemblyNodeBean bean = null;
		
		/*replace all the comma with whitespace*/
		command = command.replaceAll(",", " ");
		String [] commandarray = command.trim().split("\\s+");
		if(commandarray.length == 0){
			//empty line, do nothing here.
		}
		else if((commandarray[0].matches("/\\*.*")) || (commandarray[0].matches(";.*"))){
			// comment line, do nothing
		}
		else{
			/* if the line is not empty nor comment, create the node bean*/
			bean = new AssemblyNodeBean();
			
			/* if begin with a . and in asmKeyword set, it is a directive*/
			if(commandarray[0].matches("\\.\\S+")){
				if(AssemblyDefinition.asmKeywords.contains(commandarray[0])){
					/*set the bean's type*/
					bean.setType(AssemblyNodeBean.Type.directive);
					/*set the keyword */
					bean.setKeyword(commandarray[0]);
					/*set the operands*/
					if (commandarray.length>1){
						if(commandarray.length ==2){
							bean.setOperand1(commandarray[1]);
						}
						else if(commandarray.length ==3){
							bean.setOperand1(commandarray[1]);
							bean.setOperand2(commandarray[2]);
						}
						else if(commandarray.length ==4){
							bean.setOperand1(commandarray[1]);
							bean.setOperand2(commandarray[2]);
							bean.setOperand3(commandarray[3]);
						}
						/*if (commandarray[0].equals(".file")){
							bean.setOperand1(commandarray[1]);
						}
						else if(commandarray[0].equals(".global")){
							bean.setOperand1(commandarray[1]);
						} 
						else if(commandarray[0].equals(".type")){
							bean.setOperand1(commandarray[1]);
							bean.setOperand2(commandarray[2]);
						}
						else if(commandarray[0].equals(".size")){
							bean.setOperand1(commandarray[1]);
							bean.setOperand2(commandarray[2]);
						}
						else if(commandarray[0].equals(".comm")){
							bean.setOperand1(commandarray[1]);
							bean.setOperand2(commandarray[2]);
							bean.setOperand3(commandarray[3]);
						}
						else if(commandarray[0].equals(".section")){
							bean.setOperand1(commandarray[1]);
							bean.setOperand2(commandarray[2]);
							bean.setOperand3(commandarray[3]);
						}
						else if(commandarray[0].equals(".byte")){
							bean.setOperand1(commandarray[1]);
						}*/
					}
				}
				else{
					/* begin with a ., but not in asmKeyword set, if ends with : , it is a label*/
					if((commandarray[0].matches("\\.\\w+:")) && (commandarray.length ==1)){
						bean.setType(AssemblyNodeBean.Type.label);
						/*set keyword*/
						bean.setKeyword(commandarray[0]);
					}
					/* begin with a ., not in asmKeyworld set, not ends with: , if contains =, it is directive*/
					else if(commandarray[1].equals("=")){
						/*set the bean's type*/
						bean.setType(AssemblyNodeBean.Type.directive);
						/*set keyword*/
						bean.setKeyword(commandarray[1]);
						/*set operands*/
						bean.setOperand1(commandarray[0]);
						bean.setOperand2(commandarray[2]);
					}
				}
			}
			/*if begin with __ and arr[1] is equal sign, it is a initialization*/
			else if((commandarray[0].matches("__\\w+"))&& commandarray[1].equals("=")){
				/*set the bean's type*/
				bean.setType(AssemblyNodeBean.Type.initialization);
				/*set keyword*/
				bean.setKeyword(commandarray[1]);
				/*set operands*/
				bean.setOperand1(commandarray[0]);
				bean.setOperand2(commandarray[2]);
			}
			/*if arr.length is 1 and ends with :, it is a label*/
			else if((commandarray.length == 1)&&(commandarray[0].matches("\\w+:"))){
				/*set the bean's type*/
				bean.setType(AssemblyNodeBean.Type.label);
				/*set keyword*/
				bean.setKeyword(commandarray[0]);
			}
			else {
				/*else it is a instruction*/
				/*set the bean's type*/
				bean.setType(AssemblyNodeBean.Type.instruction);
				/*set keyword*/
				bean.setKeyword(commandarray[0]);
				/*set operands*/
				if (commandarray.length == 2){
					bean.setOperand1(commandarray[1]);
				}
				else if (commandarray.length == 3){
					bean.setOperand1(commandarray[1]);
					bean.setOperand2(commandarray[2]);
				}
				
			}
		}
		
		return bean;
	}
	
	
	/**
	 * test
	 * unitest 
	 */
	public static void main(String [] argv){
		createFileList();
		for(Map.Entry<String, List<AssemblyNodeBean> > entry : AssemblyDefinition.beanHashMap.entrySet()){
			String key = entry.getKey();
			System.out.println(key+":");
			List<AssemblyNodeBean> beanlist = entry.getValue();
			for(AssemblyNodeBean bean: beanlist){
				System.out.println("**bean type: "+bean.getType()
									+"   keyword: "+bean.getKeyword()
									+"   operand1: "+bean.getOperand1()
									+"   operand2: "+bean.getOperand2()
									+"   operand3: "+bean.getOperand3()+"**");
			}
		}
	} 
}
