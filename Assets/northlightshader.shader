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

         varying vec4 textureCoordinates; 

         void main() // all vertex shaders define a main() function
         {
            textureCoordinates = gl_MultiTexCoord0; 

            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
               // this line transforms the predefined attribute 
               // gl_Vertex of type vec4 with the predefined
               // uniform gl_ModelViewProjectionMatrix of type mat4
               // and stores the result in the predefined output 
               // variable gl_Position of type vec4.
         }

         #endif // here ends the definition of the vertex shader


         #ifdef FRAGMENT // here begins the fragment shader

         varying vec4 textureCoordinates;  

         void main() // all fragment shaders define a main() function
         {
            gl_FragColor = texture2D(_MainTex, vec2(textureCoordinates)); 
               
         }

         #endif // here ends the definition of the fragment shader

         ENDGLSL // here ends the part in GLSL 
      }
   }
}