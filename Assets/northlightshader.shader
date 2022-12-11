Shader "GLSL basic111 shader" { // defines the name of the shader 
   
   Properties {//Define a list of values that can be passed into the shader
      _MainTex ("Texture Test", 2D) = "white" {}
      _exponent("expo", float) = 2.0
      _yexponent("yexpo", float) = 2.0
      _camerapos("camera",Vector) = (0.0,0.0,0.0)
       _cameraangle("cameraangle",Vector) = (0.0,0.0,0.0)
    _ColorBottom ("colorbot", Color) = (0,0,0,0)
    _ColorTop("top",Color) = (0,0,0,0)
      _speed("speed", float) = 1.0
      _Amp("amp",float) = 0.3
       _Ampy("ampy",float) = 3
      _Frequency("freq", float) = 0.8
      _yFrequency("yfreq", float) = 0.1
      //_index("index",int) = 0;
      
   }

   SubShader { // Unity chooses the subshader that fits the GPU best

   Tags { "Queue"="Transparent" "RenderType"="Transparent" "IgnoreProjector"="False"}  //"Queue"="Background+1501"}
      Pass { // some shaders require multiple passes
      ZWrite Off
     Blend SrcAlpha OneMinusSrcAlpha
       //AlphaToMask On
         GLSLPROGRAM // here begins the part in Unity's GLSL
        #define PI 3.1415926
             uniform vec4 array[1000];
          uniform sampler2D _MainTex;
         uniform float _Amp;
          uniform float _Ampy;
         
         uniform float _Frequency;
         uniform float _yFrequency;
         // varying vec4 textureCoordinates; 
          // in vec4 pixel_color;
         #ifdef VERTEX // here begins the vertex shader
         //uniform float _speed;
         varying vec2 textureCoordinates; 
        // uniform float ytilling = 7.0;
         //uniform float xtilling = 0.11;
         in int gl_VertexID;
         varying vec4 pos; 
         varying vec2 uv;
          uniform vec4 _Time;
         void main() // all vertex shaders define a main() function
         {
            //textureCoordinates = gl_MultiTexCoord0; 
            //create rotation matrix
            //mat4 rot;
            //float angle = PI/4.0;
            //rot[0] = vec4(cos(angle),0.0, sin(angle),0.0);
             //rot[1] = vec4(0.0,1.0, 0.0,0.0);
              //rot[2] = vec4(-sin(angle),0.0, cos(angle),0.0);
               //rot[3] = vec4(0.0,0.0, 0.0,1.0);
               uv = vec2((array[gl_VertexID].x),(array[gl_VertexID].y));
              vec4 Vert = gl_Vertex;
              Vert.z += _Amp*(sin(((_Frequency*_Time.y)+uv.x)*2*PI)) ;
                Vert.y -= _Ampy*(sin(((_yFrequency*_Time.y)+uv.x)*2*PI)) ;
             gl_Position = gl_ModelViewProjectionMatrix * Vert;
             //gl_Position.z += 0.1*sin(_Time.y);
            pos = gl_Position;
           // float xwidth = 3.0*xtilling;
            //float yheight = 3.0*ytilling;
            
            textureCoordinates = vec2((array[gl_VertexID].x/10),((array[gl_VertexID].y- (_Time.y*1.0))/80));
            //_MainTex_ST.x *= _exponent;
             //_MainTex_ST.y *= _yexponent;
            // _index += 1;

            //textureCoordinates = vec2(0.5,0.5);
               // this line transforms the predefined attribute 
               // gl_Vertex of type vec4 with the predefined
               // uniform gl_ModelViewProjectionMatrix of type mat4
               // and stores the result in the predefined output 
               // variable gl_Position of type vec4.
         }

         #endif // here ends the definition of the vertex shader


         #ifdef FRAGMENT // here begins the fragment shader
         varying vec4 pos; 
         varying vec2 textureCoordinates;  
        uniform float _exponent;
        uniform float _yexponent;
           varying vec2 uv;
         uniform vec4 _ColorBottom;
         uniform vec4 _ColorTop;
           //varying vec4 pixel_color;
         //uniform vec4 _Time;
         void main() // all fragment shaders define a main() function
         {
            vec4 acolor = texture2D(_MainTex, textureCoordinates, 0.0);
            //acolor = vec4(pow(sin((pos.x+1.5)*3.1415926/3),_exponent)*pow(sin((pos.y+1.5)*3.1415926/3),_exponent),pow(sin((pos.x+1.5)*3.1415926/3),_exponent)*pow(sin((pos.y+1.5)*3.1415926/3),_exponent),pow(sin((pos.x+1.5)*3.1415926/3),_exponent)*pow(sin((pos.y+1.5)*3.1415926/3),_exponent),0.0);                                  //* acolor.x;                                  ;//* acolor.x;
            //* acolor.y;
            //* acolor.z;
             acolor = acolor * pow(sin((uv.x)*PI),_exponent)*pow(sin((uv.y)*PI),_yexponent);
               vec4 _Color = (_ColorBottom*(1-uv.y) + _ColorTop*uv.y)*acolor.x;
               //_ColorFar = _ColorFar*2;
               //_ColorFar.a = 0.6;
            
           if (uv.x < 0.001 || uv.y < 0.001 || uv.x > 0.999 || uv.y >0.999){
              discard;
           }
         
              // vec4(gl_FragColor.a) * gl_FragColor + vec4(1.0 - gl_FragColor.a) * pixel_color
               gl_FragColor = _Color*(8.0 + 250.0*pow(cos(uv.y*PI/2.0),25.0));//*pow(cos(uv.y*3.1415926/2.0),10.0) + 0.1);
               //vec4(vec3(pow(cos(uv.y*3.1415926/2.0),10.0)),1.0);//_Colorfar*8.0*pow(cos(uv.y*3.1415926/2.0),10.0);
             gl_FragColor.a = pow(sin((uv.x)*PI),_exponent)*acolor.x*(1-pow(uv.y,0.4));
             //sqrt(pow(_ColorFar.x,2.0) + pow(_ColorFar.y,2.0)+pow(_ColorFar.z,2.0)) 
            //  gl_FragColor =  gl_LastFragData[0];
            // gl_FragColor = vec4(0.6) * gl_FragColor + vec4(0.4) * pixel_color;

              //gl_FragColor =  vec4(fract(sin(pos.x*10) * 437588.5453123),fract(sin(pos.x*10) * 437588.5453123),fract(sin(pos.x*10) * 437588.5453123),1.0);
         }

         #endif // here ends the definition of the fragment shader

         ENDGLSL // here ends the part in GLSL 
      }
   }
}