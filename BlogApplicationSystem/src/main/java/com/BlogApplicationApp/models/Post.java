package com.BlogApplicationApp.models;

import java.sql.Timestamp;

public class Post {
	private int id;
    private String title;
    private String content;
    private String imageUrl;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    public Post() {
    	
    }

	public Post(int id, String title, String content, String imageUrl, Timestamp createdAt, Timestamp updatedAt) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.imageUrl = imageUrl;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
    
}
