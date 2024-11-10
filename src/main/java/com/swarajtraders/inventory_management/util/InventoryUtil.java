package com.swarajtraders.inventory_management.util;

import java.util.Objects;

public class InventoryUtil {

	public static boolean isValidString(String checkString) {
		if (Objects.nonNull(checkString) && !"".equalsIgnoreCase(checkString)) {
			return true;
		}
		return false;
	}

}
