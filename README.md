flyem-conda-recipes
===================

This repo contains the following:

1. `flyem-recipe-specs.yaml`: A list of all (or at least most) C++ and Python software packages that FlyEM builds, annotated with the exact source locations and branches of the recipes we build. This file is designed to be used with the [`publish-conda-stack`][pcs] tool. (See below.)

2. `master-conda-build-config.yaml`: A [`conda-build` config][cbc] file, which constrains common dependencies in our stack.

3. A collection of conda recipes to build *third-party* software.  Most of the recipes listed in `flyem-recipe-specs.yaml` are not stored here; they're stored with the projects' own source code.  But for third-party packages, we've written our own conda recipes, which are stored here in the `recipes` directory.

[pcs]: https://github.com/ilastik/publish-conda-stack
[cbc]: https://docs.conda.io/projects/conda-build/en/latest/resources/variants.html
[ff]: https://anaconda.org/flyem-forge/repo
[cfp]: https://github.com/conda-forge/conda-forge-pinning-feedstock/blob/master/recipe/conda_build_config.yaml
[cbs]: https://github.com/janelia-flyem/flyem-conda-recipes/blob/master/master-conda-build-config.yaml#L32-L46

publish-conda-stack
-------------------

As time passes, the packages you've compiled and uploaded to [our channel (`flyem-forge`)][ff] will become out-of-date with respect to their dependencies (and the [`conda-forge` pinnings][cfp]).  You'll need to rebuild these packages periodically.  But if you had to do it manually, keeping the packages up-to-date would require the following steps:

1. Clone the recipe repo
2. Check out the desired branch or tag
3. Based on the contents of the recipe's `meta.yaml`, predict what the name of the compiled package tarball would be, if you were to build the recipe.
4. Now check the `flyem-forge` channel: Does that tarball name already exist?  If so, there's no need to build it again.
5. If the tarball *doesn't* yet exist on `flyem-forge`, build the recipe.  Use `conda build -m master-conda-build-config.yaml ...` to ensure compatibility with the rest of our packages.
6. Upload the newly built package to `flyem-forge`.


That's tedious.  Fortunately, there's a convenient tool that automates the process: [`publish-conda-stack`][pcs].


First, install it:

```
$ conda install -n base -c flyem-forge -c conda-forge publish-conda-stack
```

Then use it to build one or more of the recipes listed in `flyem-recipe-specs.yaml`.  For instance, here's how to build `dvid`, `libdvid-cpp`, and `neuclease`:

```
$ conda activate base
$ cd flyem-conda-recipes
$ publish-conda-stack flyem-recipe-specs.yaml dvid libdvid-cpp neuclease
```

Only the *out-of-date* packages will be built and uploaded.

**Pro Tip:** <br>
The `publish-conda-stack` tool has support for tab-completion in your shell!<br>
Try `publish-conda-stack flyem-recipe-specs.yaml dvid<TAB>`


flyem-build-container
---------------------

When building C++ packages on Linux, it's a good idea to run your build within a container which is based on an older version of Linux, to ensure maximum compatibility with various Linux distros.  We have Docker container for this purpose, pre-configured with everything you need to build our recipes.  Please see the [`flyem-build-container` repo][fbc] for details.

[fbc]: https://github.com/janelia-flyem/flyem-build-container


macOS SDK
---------

When building C++ packages on macOS, it's a good idea to configure Xcode to use an old macOS SDK, to ensure maximum compatibility with older macOS versions.  If you're using the files in this repo, then the SDK version to use is configured for you in `master-build-config.yaml`.  In that file, please see the [comments for `CONDA_BUILD_SYSROOT`][cbs] for more details.  You will need to install the macOS SDK separately before you can build these C++ packages on macOS.
