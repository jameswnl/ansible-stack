FROM registry.access.redhat.com/ubi9/ubi:latest
WORKDIR /app

RUN dnf -y update && dnf install -y iputils net-tools wget     vim-minimal python3.11 python3.11-pip python3.11-wheel     python3.11-setuptools && ln -s /bin/pip3.11 /bin/pip && ln -s /bin/python3.11 /bin/python && dnf clean all

ENV UV_SYSTEM_PYTHON=1
RUN pip install uv
RUN uv pip install --no-cache tqdm opentelemetry-sdk scikit-learn emoji pypdf pillow sentencepiece numpy blobfile transformers opentelemetry-exporter-otlp-proto-http scipy psycopg2-binary tree_sitter chardet redis aiosqlite litellm requests pandas nltk langdetect mcp pythainlp matplotlib sqlite-vec pymongo aiosqlite fastapi fire httpx uvicorn
RUN uv pip install --no-cache llama-stack
RUN pip uninstall -y uv
ENTRYPOINT ["python", "-m", "llama_stack.distribution.server.server"]

# Allows running as non-root user
RUN mkdir -p /.llama /.cache

RUN chmod -R g+rw /app /.llama /.cache
