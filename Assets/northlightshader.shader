Shader "GLSL basic111 shader" { // defines the name of the shader 
   Properties {//Define a list of values that can be passed into the shader
      _MainTex ("Texture Test", 2D) = "white" {}
      _exponent("expo", float) = 2.0
      _yexponent("yexpo", float) = 2.0
      _camerapos("camera",Vector) = (0.0,0.0,0.0)
       _cameraangle("cameraangle",Vector) = (0.0,0.0,0.0)
    _ColorFar ("color far from point", Color) = (0,0,0,0)
    _speed("speed", float) = 1.0
      //_index("index",int) = 0;
      
   }

   SubShader { // Unity chooses the subshader that fits the GPU best
      Pass { // some shaders require multiple passes
         GLSLPROGRAM // here begins the part in Unity's GLSL
             uniform vec4 array[1000];
          uniform sampler2D _MainTex;

         // varying vec4 textureCoordinates; 

         #ifdef VERTEX // here begins the vertex shader
         //uniform float _speed;
         varying vec2 textureCoordinates; 
         uniform float ytilling = 7.0;
         uniform float xtilling = 0.11;
         in int gl_VertexID;
         varying vec4 pos; 
         varying vec2 uv;
          uniform vec4 _Time;
         void main() // all vertex shaders define a main() function
         {
            //textureCoordinates = gl_MultiTexCoord0; 

            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
             gl_Position.z += 0.4*sin(_Time.y);
            pos = gl_Position;
            float xwidth = 3.0*xtilling;
            float yheight = 3.0*ytilling;
            uv = vec2((array[gl_VertexID].x),(array[gl_VertexID].y));
            textureCoordinates = vec2((array[gl_VertexID].x/10),((array[gl_VertexID].y- (_Time.y*1.0))/50));
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
         uniform vec4 _ColorFar;
         //uniform vec4 _Time;
         void main() // all fragment shaders define a main() function
         {
            vec4 acolor = texture2D(_MainTex, textureCoordinates, 0.0);
            //acolor = vec4(pow(sin((pos.x+1.5)*3.1415926/3),_exponent)*pow(sin((pos.y+1.5)*3.1415926/3),_exponent),pow(sin((pos.x+1.5)*3.1415926/3),_exponent)*pow(sin((pos.y+1.5)*3.1415926/3),_exponent),pow(sin((pos.x+1.5)*3.1415926/3),_exponent)*pow(sin((pos.y+1.5)*3.1415926/3),_exponent),0.0);                                  //* acolor.x;                                  ;//* acolor.x;
            //* acolor.y;
            //* acolor.z;
            acolor = acolor*pow(sin((uv.x)*3.1415926),_exponent)*pow(sin((uv.y)*3.1415926),_yexponent);
               vec4 _Colorfar = _ColorFar*acolor.x;


             gl_FragColor = _Colorfar;
            

              //gl_FragColor =  vec4(fract(sin(pos.x*10) * 437588.5453123),fract(sin(pos.x*10) * 437588.5453123),fract(sin(pos.x*10) * 437588.5453123),1.0);
         }

         #endif // here ends the definition of the fragment shader

         ENDGLSL // here ends the part in GLSL 
      }
   }
}