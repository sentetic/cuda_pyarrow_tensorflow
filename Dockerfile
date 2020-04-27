FROM nvidia/cuda:10.1-devel-ubuntu18.04

ENV PARQUET_TEST_DATA=/repos/arrow/cpp/submodules/parquet-testing/data
ENV ARROW_TEST_DATA=/repos/arrow/testing/data
ENV ARROW_HOME=/repos/arrow/dist
ENV PYARROW_WITH_PARQUET=1
ENV PYARROW_WITH_CUDA=1

RUN apt-get update && apt-get upgrade -y \
    && apt-get install git \
    wget \
    libssl-dev \
    autoconf \
    flex \
    bison \
    llvm-7 \
    clang \
    cmake \
    python3-pip \
    libjemalloc-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-system-dev \
    libboost-regex-dev  \
    python3-dev -y

RUN git clone https://github.com/apache/arrow.git /repos/arrow

WORKDIR /repos/arrow

RUN git submodule init && git submodule update \
    && git checkout apache-arrow-0.17.0

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

RUN pip3 install six numpy pandas cython pytest hypothesis \
    && mkdir dist

COPY ./pyarrow-0.17.0-cp36-cp36m-linux_x86_64.whl /repos/arrow/python/dist/

RUN pip3 install /repos/arrow/python/dist/pyarrow-0.17.0-cp36-cp36m-linux_x86_64.whl

WORKDIR /root

CMD ["bash"]

