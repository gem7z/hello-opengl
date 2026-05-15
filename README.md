# Hello-OpenGL

A beginner's follow-along of the [learnopengl](https://learnopengl.com/) tutorial.

## Dependencies

- Any compiler that supports C++ 20:
  [MSVC](https://visualstudio.microsoft.com/downloads/?q=build+tools),
  [GCC](https://gcc.gnu.org/), [Clang](https://clang.llvm.org/)
- [CMake](https://cmake.org/) v3.30+
- [Ninja](https://github.com/ninja-build/ninja) v1.13.2+
- [LLVM](https://github.com/llvm/llvm-project) for clang-format (Optional)

This project vendors the [GLFW](https://github.com/glfw/glfw) and [GLAD](https://github.com/dav1dde/glad) as
third-party libraries, statically linked to a runnable hello-opengl executable.

## Build

After installing the necessary dependencies and adding them to system PATH, building is trivial.

For building debug:

```bash
cmake --preset debug
cmake --build --preset debug
```

For building release:

```bash
cmake --preset release
cmake --preset --build release
```

For formatting source files (_does not format third party libraries_), you first need to invoke a preset of either
debug or release, then run the `format` target:

```bash
cmake --preset debug    # or cmake --preset release
cmake --build --preset format
```

## License

This is **free and open-source** software licensed under
the [GNU Affero General Public License v3.0](https://www.gnu.org/licenses/agpl-3.0.en.html). The
AGPLv3 is a strong _copyleft_ license.

See the [LICENSE](LICENSE.md) file about copyright, redistribution, and rules about preserving the
open-source nature of the project.
