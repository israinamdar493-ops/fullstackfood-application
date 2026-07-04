package com.tap.model;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    // Map of Menu ID to CartItem for faster updates (O(1) time complexity)
    private Map<Integer, CartItem> items;

    public Cart() {
        this.items = new HashMap<>();
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }
}
