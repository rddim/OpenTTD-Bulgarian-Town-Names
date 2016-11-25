---
OpenTTD Bulgarian Town Names
===
---
 * [Building from the source on Windows](#building-from-the-source-on-windows)
 * [Building from the source on Linux](#building-from-the-source-on-linux)
 * [Wiki](../../wiki/)

Building from the source on Windows
---
* [Install NML with the all requirements](http://newgrf-specs.tt-wiki.net/wiki/NML:Getting_started)
* Download the latest source code release from
<https://github.com/rddim/openttd-bulgarian-town-names/releases/latest>
and extract the archive to the chosen destination directory.

    Development files can be browsed via web browser or can be obtained
    from a git repository <https://github.com/rddim/openttd-bulgarian-town-names>.

    *Note: You can also get the sources using the
    [GIT](http://git-scm.com/book/en/Getting-Started-Installing-Git) and
    cloning the `https://github.com/rddim/openttd-bulgarian-town-names.git` repository.*

* Build the NewGRF:  
   * **Method 1**
     * put the *`src`* folder and the *`compile_newgrf_win32.bat`* file to the main *`nml-vXXXX-windows-win32`* directory
     * run the *`compile_newgrf_win32.bat`* file
     * find your compiled NewGRF in the *`build`* directory
   
   * **Method 2**
     * put the *`lang`* folder and the *`bg_names.nml`* file from the *`src`* to the main *`nml-vXXXX-windows-win32`* directory
     * open *`command prompt`* and navigate to the *`nml-vXXXX-windows-win32`* directory
     * type *`nmlc bg_names.nml --grf=bg_names.grf`* and press enter
     * find your compiled *`bg_names.grf`* file in the same directory

* Copy the NewGRF file to the OpenTTD NewGRF directory
* For more information use the [Wiki](../../wiki/)

Building from the source on Linux
---
* To make your build on Linux, you can try here https://github.com/knutux/openttd-lithuanian-town-names
