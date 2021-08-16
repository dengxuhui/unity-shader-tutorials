//移动端标准shader
Shader "Aer/Mobile/Standard"{
    Properties{
        // 主要纹理
        _MainTex("MainTex",2D) = "white" {}
        // 颜色、亮度、对比度开关
        [Toggle(COLOR_ON)]_ColorToggle("Color,Brightness,Contrast",int) = 0
        // 颜色
        _Color("Color",Color) = (1,1,1)
        // 亮度
        _Brightness("Brightness",Range(-10,10)) = 0.0
        // 对比度
        _Contrast("Contrast",Range(0.0,3.0)) = 1.0
        

        [Toggle(PHONG_ON)] _Phong("Point Light",int) = 0
        _PointLightColor("Point Light Color",Color) = (1,1,1,1)
        _PointLightPosition("Point Light Position",Vector) = (0.0,0.0,0.0)
        _AmbiencePower("Ambience Intensity",Range(0.0,2.0)) = 1.0
        _SpecularPower("Specular Intensity",Range(0.0,2.0)) = 1.0
        _DiffusePower("Diffuse Intensity",Range(0.0,2.0)) = 1.0

        [Toggle(DETAIL_ON)] _Detail("Detail Map Toggle",int) = 0
        _DetailMap("Detail Map",2D) = "white" {}
        _DetailStrength("Detail Map Strength",Range(0.0,2.0)) = 1.0
        [Toggle(DETAIL_MASK_ON)] _Mask("Detail Mask Toggle",int) = 0
        _DetailMask("Detail Mask",2D) = "white" {}

        [Toggle(EMISSION_ON)] _Emission("Emission Map Toggle",int) = 0
        _EmissionMap("Emission",2D) = "white" {}
        _EmissionStrength("Emission Strength",Range(0.0,10.0)) = 1.0

        [Toggle(NORMAL_ON)] _Normal("Normal Map Toggle",int) = 0
        _NormalMap("Normal Map",2D) = "white" {}
    }

    SubShader{
        Tags{"RenderType" = "Opaque"}
        LOD 150
        Pass{
            Tags{"LightMode" = "VertexLM"}
            Lighting Off
            Cull Back
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #pragma multi_compile_fog
            #pragma skip_variants FOG_LINEAR FOG_EXP
            
            #pragma shader_feature COLOR_ON
            #pragma shader_feature PHONG_ON
            #pragma shader_feature DETAIL_ON
            #pragma shader_feature DETAIL_MASK_ON
            #pragma shader_feature EMISSION_ON
            #pragma shader_feature NORMAL_ON
            #include "MobileStandard.cginc"
            ENDCG
        }
    }

    Fallback "Mobile/VertexLit"
}