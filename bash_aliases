alias crd='cd $CHROMEDIR'
alias wkd='cd $WEBKITDIR'

alias t='time ctags -R --languages=C,C++,Python --exclude=build --exclude=autoinstalled --exclude=WebCore/inspector --exclude=LayoutTests --exclude=out --exclude=out_asan'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# all the build configs, whee
alias gencfgs='time ./build/gyp_chromium -Gconfig=Release && time ./build/gyp_chromium -Gconfig=Debug -Dcomponent=shared_library'
alias profcfg='time ./build/gyp_chromium -Gconfig=Release -Dprofiling=1 -Dlinux_fpic=0 -Ddisable_nacl=1'

# normal non-goma build stuff
alias n='time ninja -C out/Debug'
alias nr='time ninja -C out/Release'

# normal goma stuff
alias gn='time PATH=$GOMAPATH:$PATH ninja -C out/Debug -j$GOMAJ'
alias gnr='time PATH=$GOMAPATH:$PATH ninja -C out/Release -j$GOMAJ'

alias cmdprefix='./out/Debug/chrome --disable-hang-monitor --disable-seccomp-sandbox --disable-seccomp-filter-sandbox --renderer-cmd-prefix="xterm -e gdb --args"'
alias cmdprefixrun='./out/Debug/chrome --disable-hang-monitor --disable-seccomp-sandbox --disable-seccomp-filter-sandbox --renderer-cmd-prefix="xterm -e gdb --eval-command=run --args"'

alias lts='gn DumpRenderTree && time ./webkit/tools/layout_tests/run_webkit_tests.sh --no-new-test-results --debug'
alias ltsr='gnr DumpRenderTree && time ./webkit/tools/layout_tests/run_webkit_tests.sh --no-new-test-results --release'

# normal config gpu tests
alias gpu_lts='gn DumpRenderTree && time ./webkit/tools/layout_tests/run_webkit_tests.sh --no-new-test-results --platform=chromium-gpu --debug'
alias gpu_ltsr='gnr DumpRenderTree && time ./webkit/tools/layout_tests/run_webkit_tests.sh --no-new-test-results --platform=chromium-gpu --release'

# threaded config gpu tests
alias gpu_ltst='gpu_lts --threaded-compositing'
alias gpu_ltstr='gpu_ltsr --threaded-compositing'

# normal config unit tests
alias wkt='gn webkit_unit_tests && ./out/Debug/webkit_unit_tests'
alias wktr='gnr webkit_unit_tests && ./out/Release/webkit_unit_tests'
alias cct='gn cc_unittests && ./out/Debug/cc_unittests'
alias cctr='gnr cc_unittests && ./out/Release/cc_unittests'

# asan rules - http://www.chromium.org/developers/testing/addresssanitizer
alias asan_cfg='time ./build/gyp_chromium -Gconfig=Release -Dasan=1 -Dlinux_use_tcmalloc=0 -Ddisable_nacl=1 -Drelease_extra_cflags="-g -O1 -fno-inline-functions -fno-inline" -Goutput_dir=out_asan'
# FIXME: make asan compile with goma
alias asan_n='time ninja -C out_asan/Release -j30'
alias asan_wkt='asan_n webkit_unit_tests && ./out_asan/Release/webkit_unit_tests'
alias asan_wkt_symbol='asan_n webkit_unit_tests && ./out_asan/Release/webkit_unit_tests | ./third_party/asan/scripts/asan_symbolize.py | c++filt'

# changelog merge order depends on if you're rebasing or merging. both are useful at times
alias wk_merge='git config merge.changelog.driver "perl $WEBKITDIR/Tools/Scripts/resolve-ChangeLogs --merge-driver %O %B %A" && git merge'
alias wk_rebase='git config merge.changelog.driver "perl $WEBKITDIR/Tools/Scripts/resolve-ChangeLogs --merge-driver %O %A %B" && git rebase'

