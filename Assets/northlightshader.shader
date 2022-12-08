Shader "GLSL basic111 shader" { // defines the name of the shader 
   Properties {//Define a list of values that can be passed into the shader
      _MainTex ("Texture Test", 2D) = "white" {}
      
   }

   SubShader { // Unity chooses the subshader that fits the GPU best
      Pass { // some shaders require multiple passes
         GLSLPROGRAM // here begins the part in Unity's GLSL

         uniform sampler2D _MainTex;

         // varying vec4 textureCoordinates; 

         #ifdef VERTEX // here begins the vertex shader

         varying vec2 textureCoordinates; 
         uniform float ytilling = 7.0;
         uniform float xtilling = 0.11;
         varying vec4 pos; 
         void main() // all vertex shaders define a main() function
         {
            //textureCoordinates = gl_MultiTexCoord0; 

            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            pos = gl_Position;
            float xwidth = 3.0*xtilling;
            float yheight = 3.0*ytilling;
            textureCoordinates = vec2((gl_Position.x-1.5)/(20.0),(gl_Position.y-1.5)/(200.0));
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
         
         void main() // all fragment shaders define a main() function
         {
            gl_FragColor = texture2D(_MainTex, textureCoordinates, 0.0);

              //gl_FragColor =  vec4(fract(sin(pos.x*10) * 437588.5453123),fract(sin(pos.x*10) * 437588.5453123),fract(sin(pos.x*10) * 437588.5453123),1.0);
         }

         #endif // here ends the definition of the fragment shader

         ENDGLSL // here ends the part in GLSL 
      }
   }
}