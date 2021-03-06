USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TRAER_CODIGOS_GESTION]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CON_TRAER_CODIGOS_GESTION](
                                          @id_Sistema        Char(3),
                                          @nTipo_Resultado   Numeric(1)
                                        ) 
AS
BEGIN




   	SET DATEFORMAT DMY
	SET NOCOUNT ON

    IF CHARINDEX( @id_Sistema , 'INV,BTR' ) <> 0 BEGIN

        IF @nTipo_Resultado=1   BEGIN --FAMILIAS            

            IF @id_Sistema='BTR' BEGIN
                SELECT 
                    incodigo ,
                    inserie  ,
                    inglosa  ,
                    inrutemi ,   
                    inmonemi 
                FROM INSTRUMENTO
            END 
--            IF @id_Sistema='INV' BEGIN
--                SELECT 
--                    Cod_familia ,
--                    Nom_Familia          ,
--                    Descrip_familia      
--                FROM VIEW_INSTRUMENTO_INVERSION_EXTERIOR
--            END
        END
    
        IF @nTipo_Resultado=2   BEGIN --TIPO_CARTERA
            SELECT 
                Id_Sistema ,
                Codigo_Producto ,
                Codigo_Subproducto='' ,
                Codigo_Cartera ,
                Descripcion
            FROM TIPO_CARTERA WHERE ID_SISTEMA=@ID_SISTEMA        
        END
    
        IF @nTipo_Resultado=3   BEGIN --FORMA DE PAGO
            SELECT 
                codigo ,
                glosa    ,
                perfil    ,
                codgen ,
                glosa2   
            FROM FORMA_DE_PAGO
        END
    
        IF @nTipo_Resultado=4   BEGIN --MONEDA
            SELECT 
                mncodmon     ,
                mnnemo       ,
                mnsimbol     ,
                mnglosa      
            FROM MONEDA
        END
    
        IF @nTipo_Resultado=5   BEGIN --EMISOR
            SELECT 
                emcodigo    ,
                emrut       ,
                emdv        ,
                emnombre    ,
                emgeneric  
            FROM EMISOR
        END
    
        IF @nTipo_Resultado=6   BEGIN --TIPO_TASA
            SELECT 
                Codigo_Variabilidad ,
                Descripcion                                        
            FROM MONEDA_VARIABILIDAD
        END
    
        IF @nTipo_Resultado=7   BEGIN --TIPO_OPERACION
            SELECT 
                Id_Sistema ,
                Codigo_Producto ,
                Descripcion     ,
                Contabiliza ,
                Gestion 
            FROM PRODUCTO WHERE ID_SISTEMA=@ID_SISTEMA   
        END

    END
    
    IF @nTipo_Resultado=8   BEGIN --SISTEMAS
        SELECT 
            id_sistema ,
            nombre_sistema  ,
            operativo ,
            gestion ,
            activo ,
            Orden 
        FROM SISTEMA
    END

    IF @nTipo_Resultado=9   BEGIN --CODIGOS DE GESTION
        SELECT 
            id_sistema	        ,
            codigo_familia	,
            correlativo	        ,
            activo_pasivo	,
            tipo_cartera	,
            sub_grupo	        ,
            forma_pago_ini	,
            foma_pago_fin	,
            codigo_moneda	,
            rut_emisor	        ,
            tipo_tasa	        ,
            tipo_operacion	
        FROM GESTION_TESORERIA  WHERE @id_Sistema=id_Sistema
    END

    
END
GO
