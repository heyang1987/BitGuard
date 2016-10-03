/**
 * 
 */
package edu.clemson.dsrg.bg;

import java.io.File;
import java.util.ArrayList;
import java.util.List;


/**
 * @author jonas
 *
 */
public class DataStore {
	//static{
		//assemblyFileList = new ArrayList<File>();
	//}
	
	public static List<File> getAssemblyFileList() {
		return assemblyFileList;
	}
	
	private static List<File> assemblyFileList = new ArrayList<File>();
}
	