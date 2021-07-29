Shader "CN/Unlit/Screen Position"{
    Properties{
        _MainTex("Texture",2D) = "white" {}
    }
    SubShader{
        Pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            //只有3.0才开始支持屏幕空间像素位置：VPOS
            #pragma target 3.0

            //没有SV_POSITION
            struct v2f {
                float2 uv : TEXCOORD0;
            };

            v2f vert(float4 vertex : POSITION,float2 uv : TEXCOORD0,out float4 outpos : SV_POSITION){
                v2f o;
                o.uv = uv;
                outpos = UnityObjectToClipPos(vertex);
                return o;
            }
            sampler2D _MainTex;
            //UNITY_VPOS_TYPE 类型（在大多数平台上将是 float4，在 Direct3D9 上将是 float2）
            fixed4 frag(v2f i,UNITY_VPOS_TYPE screenPos : VPOS):SV_TARGET{
                screenPos.xy = floor(screenPos.xy * 0.25) * 0.5;
                float checker = -frac(screenPos.r + screenPos.g);
                clip(checker);

                fixed4 c = tex2D(_MainTex,i.uv);
                return c;
            }
            ENDCG
        }
    }
}