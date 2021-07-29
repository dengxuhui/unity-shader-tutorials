Shader "CN/Unlit/WorldSpaceNormals"{
    SubShader{
        Pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            struct v2f{
                half3 worldNormal : COLOR0;
                float4 pos : SV_POSITION;
            };
            v2f vert(float4 vertex : POSITION,float3 normal : NORMAL){
                v2f o;
                o.pos = UnityObjectToClipPos(vertex);
                o.worldNormal = UnityObjectToWorldNormal(normal);
                return o;
            }
            fixed4 frag(v2f i) : SV_Target{
                fixed4 c = 0;
                // 法线是具有 xyz 分量的 3D 矢量；处于 -1..1
                // 范围。要将其显示为颜色，请将此范围设置为 0..1
                // 并放入红色、绿色、蓝色分量
                c.rgb = i.worldNormal * 0.5 + 0.5;
                return c;
            }
            ENDCG
        }
    }
}