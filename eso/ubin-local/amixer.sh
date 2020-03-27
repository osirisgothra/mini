_amixer () {
	typeset -A _amixer_args
	local -a args
	_amixer_args=(all "print all basic information" kernel-name "print kernel name" nodename "print network node hostname" kernel-release "print kernel release" kernel-version "print kernel version" os-release "print operating system release level" machine "print machine hardware name" processor "print processor type" hardware-platform "print hardware platform" operating-system "print name of the operating system" help "display help information" version "output version information and exit")  ;;
	if _pick_variant gnu="Free Soft" unix --version
	then
		_arguments -s '(-)'{--all,-a}'['$_amixer_args[all]']' '(--kernel-name -s)'{--kernel-name,-s}'['$_amixer_args[kernel-name]']' '(--nodename -n)'{--nodename,-n}'['$_amixer_args[nodename]']' '(--kernel-release -r)'{--kernel-release,-r}'['$_amixer_args[kernel-release]']' '(--kernel-version -v)'{--kernel-version,-v}'['$_amixer_args[kernel-version]']' '(--machine -m)'{--machine,-m}'['$_amixer_args[machine]']' '(--processor -p)'{--processor,-p}'['$_amixer_args[processor]']' '(--hardware-platform -i)'{--hardware-platform,-i}'['$_amixer_args[hardware-platform]']' '(--operating-system -o)'{--operating-system,-o}'['$_amixer_args[operating-system]']' '(-)--help['$_amixer_args[help]']' '(-)--version['$_amixer_args[version]']'
	else
		args=("(-m -n -r -s -v)-a[${_amixer_args[all]}]" '-m[print hardware class]' "-n[${_amixer_args[nodename]}]" "-p[${_amixer_args[processor]}]" "-r[${_amixer_args[os-release]}]" "-s[${_amixer_args[operating-system]}]" '-v[print detailed operating system version]') 
		case $OSTYPE in
			(freebsd* | dragonfly*) args+=('-i[print kernel ident]')  ;|
			(freebsd<10->.*) args+=('-K[print FreeBSD kernel version]' '-U[print FreeBSD user environment version]')  ;;
			(solaris*) args+=('-i[print platform name]' '-S[set system name]:system name' '-X[print expanded system information]')  ;;
		esac
		_arguments -s $args
	fi
}
