@REM 关闭回显，不显示正在执行的批处理命令及执行的结果等。
@echo off

@REM 工程输出
echo "stream server windows version, make vs project."

@REM 调用脚本
call :prepare_env
call :build_vs

pause

goto :EOF

@REM 1.设置环境变量
:prepare_env
echo "call env.bat if exist"
if exist env.bat (call env.bat)

goto :EOF


@REM 2.生成vs工程
:build_vs

if defined WATCH_VC_DIR  (
	echo "has WATCH_VC_DIR in env.bat"
)  else  (
	echo "please set the 1 env variables: WATCH_VC_DIR in env.bat, and retry again."
	pause
	exit
)

call "%WATCH_VC_DIR%\vcvarsall.bat" amd64

if exist build (echo "build folder exist.") else (md build)
cd build/

echo "%WATCH_VCPKG_DIR%/scripts/buildsystems/vcpkg.cmake"

cmake ../ -DCMAKE_TOOLCHAIN_FILE="%WATCH_VCPKG_DIR%/scripts/buildsystems/vcpkg.cmake"
cd ../

goto :EOF