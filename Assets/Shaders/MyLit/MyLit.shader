Shader "Unlit/MyLit"
{
	Properties{
	  [Header(Surface options)] // Creates a text header
	  // [MainTexture] and [MainColor] allow Material.mainTexture and Material.color to use the correct properties
	  //[MainTexture] _ColorMap("Color", 2D) = "white" {}
	   _ColorA ("ColorA", Color) = (1,1,1,1)
	   _ColorB ("ColorB", Color) = (1,1,1,1)
	   _ColorStart ("Color Start", Float) = 1
	   _ColorEnd ("Color End", Float) = 0
	}
	SubShader{
	Tags {"RenderType" = "Opaque"}
	Pass{
		//Name "ForwardLit"
		//Tags{"LightMode" = "UniversalForward"}
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"
				//#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/*"
				#define TAU 6.28318530718

				float4 _ColorA;
				float4 _ColorB;
				float _ColorStart;
				float _ColorEnd;
				//float _Scale;
				//float _Offset;
				//the input for this part will be auto filled by unity
				struct MeshData {
					float4 vertex : POSITION; // vertex POSITION
					float3 normal : NORMAL;
					float4 uv0 : TEXCOORD0;

				};

				struct Interpolators { //pass data from vertex to fragment
					float4 vertex : SV_POSITION; //SV_POSITION = clip space position of this vertex
				//	float2 uv : TEXCOORD0; // 
					float3 normal : TEXCOORD0;
					float2 uv: TEXCOORD1;
				};

				Interpolators vert (MeshData v){
					Interpolators output;
					output.vertex = UnityObjectToClipPos(v.vertex);//convert local space to clip space;
					output.normal = UnityObjectToWorldNormal(v.normal);
					//output.uv = (v.uv0 + _Offset) * _Scale;
					output.uv = v.uv0;
					return output;
				};

				// DATA TYPES	
				// float (32 bit)
				// half (16 bit);
				// fixed (very low bit) only used -1 to 1 Range
				// float4x4 4 by 4 matrix
				// bool 0 1
				// int
				float InverseLerp(float a, float b, float v){
					return (v-a)/(b-a);
				};
				float4 frag(Interpolators i) : SV_TARGET{ 
					//blend 2 color based on x uv coordinate
					//lerp: blend between 2 values based on a third value 0-1
					//return float4(i.uv,0, 1);

					//float t = saturate(InverseLerp(_ColorStart, _ColorEnd, i.uv.x));
					//t = frac(t);

					float t = cos(i.uv.x * TAU * 2) * 0.5;
					return t;

					//float4 outColor = lerp( _ColorA, _ColorB, t);
					//frac = v - floor(v);

					//return outColor;
				};
				ENDCG

		 //HLSLPROGRAM // Begin HLSL code
			// Register our programmable stage functions
			//#pragma vertex Vertex
	//#pragma fragment Fragment

			// Include our code file
			//#include "MyLitForwardLitPass.hlsl"
			//ENDHLSL
				
	}

	}
	
}
