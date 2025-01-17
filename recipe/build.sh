#!/bin/bash

set -exo pipefail

if [[ ${cuda_compiler_version} != "None" ]]; then
  with_cuda_backend=ON
else
  with_cuda_backend=OFF
fi

if [[ "${target_platform}" == linux* ]]; then
  with_opencl_backend=ON
else
  with_opencl_backend=OFF
fi

if [[ "${target_platform}" == linux-64 ]]; then
  with_rocm_backend=ON
else
  with_rocm_backend=OFF
fi

cmake \
  $SRC_DIR \
  ${CMAKE_ARGS} \
  -G Ninja \
  -B build \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DWITH_CUDA_BACKEND=$with_cuda_backend \
  -DWITH_OPENCL_BACKEND=$with_opencl_backend \
  -DWITH_ROCM_BACKEND=$with_rocm_backend

cmake --build build --parallel

cmake --install build --strip
