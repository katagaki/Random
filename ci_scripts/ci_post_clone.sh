#!/bin/bash
set -euo pipefail

ASSETS_REPO="https://${ASSETS_PAT}@github.com/katagaki/RandomAssets.git"
ASSETS_DIR="$CI_PRIMARY_REPOSITORY_PATH/ci_scripts/_assets"
SCENE_ASSETS_DIR="$CI_PRIMARY_REPOSITORY_PATH/Randomly/Scene Assets.scnassets"

echo "Cloning private assets..."
git clone --depth 1 "$ASSETS_REPO" "$ASSETS_DIR"

echo "Copying scene models..."
cp "$ASSETS_DIR/Dice.scn" "$SCENE_ASSETS_DIR/Dice.scn"
cp "$ASSETS_DIR/Coin.scn" "$SCENE_ASSETS_DIR/Coin.scn"

echo "Cleaning up..."
rm -rf "$ASSETS_DIR"

echo "Assets installed successfully."
