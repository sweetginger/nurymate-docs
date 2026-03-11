#!/bin/bash
# 프라이빗 레포에서 docs 파일 동기화
# 실행: bash sync.sh (pm-advanced-harness 루트에서)

SRC="../products/nurymate/strategy"
DST="./docs"

echo "Syncing from $SRC..."

cp "$SRC/overview.md" "$DST/index.md"

for f in product-plan.md business-roadmap.md strategic-analysis.md pricing-model.md \
         early-customer-acquisition.md new-seller-acquisition.md organic-growth.md \
         global-expansion-roadmap.md vertical-expansion.md japan-gtm.md api-policy.md; do
  cp "$SRC/$f" "$DST/strategy/$f"
done

cp "$SRC/research/"*.md "$DST/research/"
cp "$SRC/spec/"*.md "$DST/spec/"

echo "Sync complete. Run 'mkdocs build' to verify."
