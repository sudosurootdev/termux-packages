TERMUX_PKG_HOMEPAGE=https://libevent.org/
TERMUX_PKG_DESCRIPTION="Library that provides asynchronous event notification"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_VERSION=2.1.10
TERMUX_PKG_SHA256=52c9db0bc5b148f146192aa517db0762b2a5b3060ccc63b2c470982ec72b9a79
TERMUX_PKG_SRCURL=https://github.com/libevent/libevent/archive/release-${TERMUX_PKG_VERSION}-stable.tar.gz
# Strip away libevent core, extra and openssl libraries until someone uses them
TERMUX_PKG_RM_AFTER_INSTALL="bin/event_rpcgen.py lib/libevent_*"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DEVENT__BUILD_SHARED_LIBRARIES=ON
-DEVENT__DISABLE_BENCHMARK=ON
-DEVENT__DISABLE_OPENSSL=ON
-DEVENT__DISABLE_REGRESS=ON
-DEVENT__DISABLE_SAMPLES=ON
-DEVENT__DISABLE_TESTS=ON
-DEVENT__DISABLE_TESTS=ON
-DEVENT__HAVE_WAITPID_WITH_WNOWAIT=ON
-DEVENT__SIZEOF_PTHREAD_T=$((TERMUX_ARCH_BITS/8))
"
termux_step_post_make_install() {
	# Building with cmake does not install .pc files, see
	# https://github.com/libevent/libevent/issues/443
	cat > "$PKG_CONFIG_LIBDIR/libevent.pc" <<-HERE
		Name: libevent
		Description: libevent is an asynchronous notification event loop library
		Version: ${TERMUX_PKG_VERSION}-stable
		Libs: -levent
	HERE
}
