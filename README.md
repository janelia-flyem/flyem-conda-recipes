flyem-conda-recipes
===================

This repo contains the following:

1. `flyem-recipe-specs.yaml`: A list of all (or at least most) C++ and Python software packages that FlyEM builds, annotated with the exact source locations and branches of the recipes we build. This file is designed to be used with the [`publish-conda-stack`][pcs] tool. (See below.)

2. `master-conda-build-config.yaml`: A [`conda-build` config][cbc] file, which is used to constrain the versions of certain common dependencies in our stack.

3. A collection of conda recipes to build *third-party* software.  Note that most of the recipes listed in `flyem-recipe-specs.yaml` are *not* stored here in this collection.  That's because many software packages include a conda recipe directly in their own git repos.  But sometimes we need to build a third-party package that does not include its own conda recipe.  In those cases, we have written custom conda recipes, and we store them here.

[pcs]: https://github.com/ilastik/publish-conda-stack
[cbc]: https://docs.conda.io/projects/conda-build/en/latest/resources/variants.html


publish-conda-stack
-------------------

As time passes, the packages you've compiled and uploaded to our channel (`flyem-forge`) may lag behind the latest versions you would get if you were to re-build the recipes listed here.  To ensure that a particular package on our channel is up-to-date, you would need to do the following:

1. Clone the recipe repo
2. Check out the desired branch or tag
3. Based on the contents of the recipe's `meta.yaml`, predict what the name of the compiled package tarball would be, if you were to build the recipe.
4. Now check the `flyem-forge` channel: Does that tarball name already exist?  If so, there's no need to build it again.
5. If the tarball *doesn't* yet exist on `flyem-forge`, build the recipe.  Use `conda build -m master-conda-build-config.yaml ...` to ensure compatibility with the rest of our packages.
6. Upload the newly built package to `flyem-forge`.


The above process would be tedious to perform manually.  Fortunately, there's a convenient tool that automates it: [`publish-conda-stack`][pcs].

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

When building C++ packages on macOS, it's a good idea to configure Xcode to use an old macOS SDK, to ensure maximum compatibility with older macOS versions.  If you're using the files in this repo, then the SDK version to use is configured for you in `master-build-config.yaml`.  In that file, please see the comments for `CONDA_BUILD_SYSROOT` for more details.  You will need to install the macOS SDK separately before you can build these C++ packages on macOS.
