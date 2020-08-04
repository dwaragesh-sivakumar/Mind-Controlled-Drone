// Created to produce a live footage (Back-end program for Raspberri Pi Camera to trigger for a live footage)

package com.example.appforit;

        import androidx.appcompat.app.AppCompatActivity;
        import android.os.Bundle;
        import android.view.View;
        import android.webkit.WebView;
        import android.webkit.WebViewClient;
        import android.widget.Button;

public class MainActivity extends AppCompatActivity 
{
        @Override
        public <T extends View> T findViewById(int id) { return super.findViewById(id); }

        @Override
        protected void onCreate(Bundle savedInstanceState) 
        {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);

            webviewbih = (WebView) findViewById(R.id.webview);
            webviewbih.setVisibility(View.GONE);

            btn2.setVisibility(View.GONE);

            btn = (Button) findViewById(R.id.btnboa);
            numba = txt.toString();
            btn.setOnClickListener((view) -> 
            {
                webviewbih.setVisibility(View.VISIBLE);
                btn2.setVisibility(View.VISIBLE);
                btn.setVisibility(View.GONE);
                txt.setVisibility(View.GONE);
                webviewbih.setWebViewClient(new WebViewClient());
                webviewbih.loadUrl("http://10.1.10.55:8000");
            });
        }

        public void onBackPressed() { webviewbih.loadUrl("http://10.1.10.55:8000"); }
}
