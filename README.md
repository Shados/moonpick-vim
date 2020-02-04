# moonpick-vim

Setup:
1. Install the `moonpick-vim` executable script using luarocks, e.g. run
   `luarocks make` while in this repository
2. Have [ale](https://github.com/dense-analysis/ale/) installed in vim
2. Add this repository as a vim plugin, using whatever plugin manager you like
3. Modify your vimrc to enable the linter, e.g.:
   ```vim
   let g:ale_linters['moon'] = ['moonpick']
   ```
