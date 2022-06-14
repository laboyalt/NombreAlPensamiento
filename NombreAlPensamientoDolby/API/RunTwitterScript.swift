//
//  RunTwitterScript.swift
//  NombreAlPensamientoDolby
//
//  Created by Angelik Laboy on 11/06/2022.
//
//  Based on the Python module from TensorFlow, Python Kit ("https://github.com/pvieito/PythonKit") makes Python code inside XCode.

import Foundation
import PythonKit

//Function allows the running of a Python script
func RunTwitterScript()-> PythonObject{
    let sys = Python.import("sys") //Imports the sys module to allow constants, functions and methods of the Python interpreter
    sys.path.append("/Users/angeliklaboy/Downloads/NombreAlPensamientoDolby/NombreAlPensamientoDolby/API/") //Needs to be changes to where the python script is located locally
    let file = Python.import("TwitterAPIScript") //Make sure to not include .py; it won't read it
    let response = file.main() //Execute the main function in the Python script
    return response //The response on the XCode terminal should be Response code: 200 twice
}
