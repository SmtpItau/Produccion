USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TURING_VALIDA_ACCESO_CARTERA_FINANCIERA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TURING_VALIDA_ACCESO_CARTERA_FINANCIERA]
						( @usuario				 as varchar(20),
						  @sistema				 as varchar(09),
						  @producto				 as varchar(04),	
						  @cartera_financiera	 as numeric(09),
                          @Existe			     as varchar(01) OUTPUT)
AS 
BEGIN

BEGIN TRY
     SET NOCOUNT ON

/*******************************************************************************************************	
   valida cartera financiera
 *******************************************************************************************************/
   if @sistema = 'PCS' 
   begin
      Select @producto = Case when @producto = '1' then 'ST' 
                              when @Producto = '2' then 'SM'
                              when @Producto = '4' then 'SP'
                              else 'FR' end 

   end
   
   if @sistema = 'BFW' 
   begin
      Select @producto = Case when @producto = '14' then '1' else @producto
                              end 

   end


   if exists(select * from bacparamsuda..TBL_REL_USU_CART_FINANCIERA 
   where         ucf_Usuario    = @usuario
   AND           UCF_SISTEMA    = @sistema
   and			 UCF_PRODUCTO   = @producto
   and           Ucf_Codigo_Cart = @cartera_financiera
   /*and           UCF_default    in( 'S'	) */ )	--Default 

       begin
                select @Existe='S'
           end
        else
           begin
                select @Existe='N'
       end
       RETURN
END TRY
Begin Catch
   -- Caso de caida
   select @Existe='N'
   RETURN
End Catch
END
GO
