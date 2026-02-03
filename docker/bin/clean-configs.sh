#!/bin/bash

if [ -d "./nodes" ]; then
    # Try normal rm first, then use Docker to handle root-owned files
    rm -rf ./nodes 2>/dev/null || {
        echo "Using Docker to clean root-owned files in ./nodes..."
        docker run --rm -v "$(pwd)/nodes:/nodes" alpine sh -c "rm -rf /nodes/*" 2>/dev/null && rm -rf ./nodes
    } || {
        # Last resort: sudo (may fail without terminal)
        sudo rm -rf ./nodes 2>/dev/null || echo "Warning: Could not remove ./nodes directory"
    }
fi