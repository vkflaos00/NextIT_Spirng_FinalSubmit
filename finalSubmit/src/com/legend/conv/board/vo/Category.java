package com.legend.conv.board.vo;

public enum Category {
	카테고리{
		@Override
		public String toString() {
			return "카테고리";
		}
	},
    잡담{
    	@Override
    	public String toString() {
    		return "잡담";
    	}
    },
    불편사항{
    	@Override
    	public String toString() {
    		return "불편사항";
    	}
    },
    구인구직{
    	@Override
    	public String toString() {
    		return "구인구직";
    	}
    }
	
	
}
