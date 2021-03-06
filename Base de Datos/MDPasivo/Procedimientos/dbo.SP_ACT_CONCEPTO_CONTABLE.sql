USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CONCEPTO_CONTABLE]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ACT_CONCEPTO_CONTABLE] (
                                         @iconcepto_contable          CHAR(5)
                                        ,@idescripcion                CHAR(50)
                                        ,@iinventario                 CHAR(1)
                                        ,@iresultado                  CHAR(1)
                                        ,@iswitch_producto            INT
                                        ,@iswitch_garantia            INT
                                        ,@iswitch_tipo_plazo          INT
                                        ,@iswitch_financia            INT
                                        ,@iswitch_sector              INT
                                        ,@iswitch_corresponsal        INT
                                        ,@iswitch_propiedad           INT
                                        ,@iswitch_cuota               INT
                                        ,@iswitch_colocacion          INT
                                        ,@iswitch_recup               INT
                                        ,@iswitch_divisa              INT
                                        ,@iswitch_tipo_moneda         INT
                                        ,@ireferencia                 INT = 0
                                        ,@iswitch_codigo_operacion    INT = 0
                                     )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


    IF EXISTS( SELECT 1 FROM CONCEPTO_CONTABLE WHERE concepto_contable = @iconcepto_contable ) BEGIN
        
        UPDATE CONCEPTO_CONTABLE
        SET  --inventario                = (CASE WHEN @iinventario                 = '' THEN inventario                 ELSE @iinventario                 END)
             resultado                 = @iresultado			--(CASE WHEN @iresultado                  = '' THEN resultado                  ELSE @iinventario                 END)
            ,switch_producto           = @iswitch_producto		--(CASE WHEN @iswitch_producto            = 0  THEN switch_producto            ELSE @iswitch_producto            END)
            ,switch_garantia           = @iswitch_garantia		--(CASE WHEN @iswitch_garantia            = 0  THEN switch_garantia            ELSE @iswitch_garantia            END)
            ,switch_tipo_plazo         = @iswitch_tipo_plazo		--(CASE WHEN @iswitch_tipo_plazo          = 0  THEN switch_tipo_plazo          ELSE @iswitch_tipo_plazo          END)
            ,switch_financia           = @iswitch_financia		--(CASE WHEN @iswitch_financia            = 0  THEN switch_financia            ELSE @iswitch_financia            END)
            ,switch_sector             = @iswitch_sector		--(CASE WHEN @iswitch_sector              = 0  THEN switch_sector              ELSE @iswitch_sector              END)
            ,switch_corresponsal       = @iswitch_corresponsal		--(CASE WHEN @iswitch_corresponsal        = 0  THEN switch_corresponsal        ELSE @iswitch_corresponsal        END)
            ,switch_propiedad          = @iswitch_propiedad		--(CASE WHEN @iswitch_propiedad           = 0  THEN switch_propiedad           ELSE @iswitch_propiedad           END)
            ,switch_cuota              = @iswitch_cuota			--(CASE WHEN @iswitch_cuota               = 0  THEN switch_cuota               ELSE @iswitch_cuota               END)
            ,switch_colocacion         = @iswitch_colocacion		--(CASE WHEN @iswitch_colocacion          = 0  THEN switch_colocacion          ELSE @iswitch_colocacion          END)
            ,switch_recup              = @iswitch_recup			--(CASE WHEN @iswitch_recup               = 0  THEN switch_recup               ELSE @iswitch_recup               END)
            ,switch_divisa             = @iswitch_divisa		--(CASE WHEN @iswitch_divisa              = 0  THEN switch_divisa              ELSE @iswitch_divisa              END)
            ,switch_tipo_moneda        = @iswitch_tipo_moneda		--(CASE WHEN @iswitch_tipo_moneda         = 0  THEN switch_tipo_moneda         ELSE @iswitch_tipo_moneda         END)
--            ,referencia                = @ireferencia			--(CASE WHEN @ireferencia                 = 0  THEN referencia                 ELSE @ireferencia                 END)
            ,switch_codigo_operacion   = @iswitch_codigo_operacion	--(CASE WHEN @iswitch_codigo_operacion    = 0  THEN switch_codigo_operacion    ELSE @iswitch_codigo_operacion    END)
        WHERE concepto_contable = @iconcepto_contable        

    END ELSE BEGIN
            
        INSERT CONCEPTO_CONTABLE
            (
                 concepto_contable          
                ,descripcion        
                ,inventario                
                ,resultado                 
                ,switch_producto           
                ,switch_garantia           
                ,switch_tipo_plazo         
                ,switch_financia           
                ,switch_sector             
                ,switch_corresponsal       
                ,switch_propiedad          
                ,switch_cuota              
                ,switch_colocacion         
                ,switch_recup              
                ,switch_divisa             
                ,switch_tipo_moneda        
                ,referencia                
                ,switch_codigo_operacion   
            )
        VALUES
            (
                 @iconcepto_contable          
                ,@idescripcion        
                ,0		-- @iinventario
                ,@iresultado                 
                ,@iswitch_producto           
                ,@iswitch_garantia           
                ,@iswitch_tipo_plazo         
                ,@iswitch_financia           
                ,@iswitch_sector             
                ,@iswitch_corresponsal       
                ,@iswitch_propiedad          
                ,@iswitch_cuota              
                ,@iswitch_colocacion         
                ,@iswitch_recup              
                ,@iswitch_divisa             
                ,@iswitch_tipo_moneda        
                ,0 		--@ireferencia                
                ,@iswitch_codigo_operacion
            )
        
    END

    SELECT 0 , 'OK'

END

GO
