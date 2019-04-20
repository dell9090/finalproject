package com.example.finalproject;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;

public class BrowsePostsActivity extends Activity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_splash);
    findViewById(R.id.go_flutter).setOnClickListener(new OnClickListener() {
      @Override
      public void onClick(View v) {
        Intent intent = new Intent(BrowsePostsActivity.this, MainActivity.class);
        BrowsePostsActivity.this.startActivity(intent);
      }
    });

    findViewById(R.id.go_flutter2).setOnClickListener(new OnClickListener() {
      @Override
      public void onClick(View v) {
        Intent intent = new Intent(BrowsePostsActivity.this, NewPostActivity.class);
        BrowsePostsActivity.this.startActivity(intent);
      }
    });
    
  }

}
