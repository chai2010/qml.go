:: Copyright 2014 <chaishushan{AT}gmail.com>. All rights reserved.
:: Use of this source code is governed by a BSD-style
:: license that can be found in the LICENSE file.

@echo off

cd %~dp0
setlocal

:: ----------------------------------------------------------------------------
:: Setup MSVC

:: VS2010
if not "x%VS100COMNTOOLS%" == "x" (
	echo Setup VS2010 Win32 ...
	call "%VS100COMNTOOLS%\..\..\VC\vcvarsall.bat"
	goto build
)

:: VS2012
if not "x%VS110COMNTOOLS%" == "x" (
	echo Setup VS2012 Win32 ...
	call "%VS110COMNTOOLS%\..\..\VC\vcvarsall.bat"
	goto build
)

:: VS2013
if not "x%VS120COMNTOOLS%" == "x" (
	echo Setup VS2013 Win32 ...
	call "%VS120COMNTOOLS%\..\..\VC\vcvarsall.bat"
	goto build
)

:build

:: ----------------------------------------------------------------------------
:: NMake: goqgl_4_3compat.dll

qmake
nmake clean
nmake release

:: ----------------------------------------------------------------------------
:: MinGW: generate libgoqgl_4_3compat.a

dlltool -dllname goqgl_4_3compat.dll --def goqgl.def --output-lib libgoqgl_4_3compat.a

:: ----------------------------------------------------------------------------
:: install

copy goqgl_4_3compat.dll %QTDIR%\bin

:: ----------------------------------------------------------------------------
:: END