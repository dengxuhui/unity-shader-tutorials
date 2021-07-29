Shader "CN/Unlit/Show Uvs"{
    SubShader{
        Pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            //存在默认定义，不需要再定义
            struct v2f{
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
            };
            //vertex：顶点位置输入 uv：第一个纹理坐标输入
            v2f vert(float4 vertex : POSITION,float2 uv : TEXCOORD0){
                v2f o;
                o.pos = UnityObjectToClipPos(vertex);
                o.uv = uv;
                return o;   
            }
            //函数frag的返回类型为fixed4（低精度RGBA颜色）。
            //因为它只返回一个值，所以语义由函数自身指示: SV_Target。
            // fixed4 frag(v2f i):SV_Target{
            //     return fixed4(i.uv,0,0);
            // }

            //返回结构体的方式
            struct fragOutput{
                fixed4 color : SV_Target;
            };
            fragOutput frag(v2f i){
                fragOutput o;
                o.color = fixed4(i.uv,0,0);
                return o;
            }

            ENDCG
        }
    }
}