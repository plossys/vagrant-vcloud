rem @echo off
setlocal
set curr=%cd:\=/%
set curr=%curr:C:=/c%
set home=%USERPROFILE:\=/%
set home=%home:C:=/c%
set image=plossys/vagrant-vcloud
if "%1" == "configure" (
  docker run --rm -it --entrypoint retrieve-vagrant-vcloud-settings.sh %image% %2 %3 %4 %5 %6 %7 %8 %9
) else (
  docker run --rm -it -v %curr%:/work -v %home%/.vagrant.d/Vagrantfile:/user/Vagrantfile -e VCLOUD_USER -e VCLOUD_PWD %image% %*
)
