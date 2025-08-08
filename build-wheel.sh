# From the repo root
TMPDIR="$(mktemp -d)" \
&& echo "Using $TMPDIR" \
&& mkdir -p "$TMPDIR/airflow/providers/cncf/kubernetes" \
&& rsync -a --delete --exclude 'dist' --exclude '__pycache__' \
     airflow/providers/cncf/kubernetes/ "$TMPDIR/airflow/providers/cncf/kubernetes/" \
&& cp airflow/providers/cncf/kubernetes/README.rst "$TMPDIR/README.rst" \
&& awk '1' "$TMPDIR/airflow/providers/cncf/kubernetes/pyproject.toml" > "$TMPDIR/pyproject.toml" \
&& python -m pip install --upgrade flit_core==3.10.1 flit >/dev/null \
&& python -m flit -f "$TMPDIR/pyproject.toml" build --format wheel \
&& mkdir -p dist \
&& cp "$TMPDIR/dist/"*.whl dist/ \
&& ls -lah dist
