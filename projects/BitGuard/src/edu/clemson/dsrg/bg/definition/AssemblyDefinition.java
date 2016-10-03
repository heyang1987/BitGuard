/**
 * 
 */
package edu.clemson.dsrg.bg.definition;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Map;
import java.util.Set;

import java.util.List;

import edu.clemson.dsrg.bg.bean.AssemblyNodeBean;


/**
 * @author jonas
 *
 */
public class AssemblyDefinition {
	
	/*
	 *  Assembly Instructions
	 */
	public static final String ASM_INSTRUCTION_PUSH = "push";
	public static final String ASM_INSTRUCTION_SBIW = "sbiw";
	public static final String ASM_INSTRUCTION_OUT = "out";
	
	/*
	 *	Assembly Registers 
	 */
	public static final String ASM_REGISTER_R28 = "r28";
	public static final String ASM_REGISTER_R29 = "r29";
	public static boolean ASM_REGISTER_R28_FLAG = false;
	public static boolean ASM_REGISTER_R29_FLAG = false;
	/*
	 *	Assembly Directives 
	 */
	public static final String ASM_DIRECTIVE_GLOBAL = ".global";
	public static final String ASM_DIRECTIVE_TEXT = ".text";
	public static final String ASM_DIRECTIVE_TYPE = ".type";
	public static final String ASM_DIRECTIVE_SIZE = ".size";
	
	/*
	 *	Assembly Keywords 
	 */
	public static final String ASM_KEYWORD_MAIN = "main";
	
	/*
	 *	 
	 */
	public static final String DIRECTORY = "assemblyfiles";
	public static LinkedList<File> asmFileList  = new LinkedList<File>();
	public static Map<String, List<AssemblyNodeBean> > beanHashMap = new HashMap <String, List<AssemblyNodeBean> >();
	public static Set<String> asmKeywords = new HashSet<String>(Arrays.asList(".arch", ".text", ".section", ".byte", ".data",".word",".global", ".file", ".type", ".size", ".comm")); 
	
}
