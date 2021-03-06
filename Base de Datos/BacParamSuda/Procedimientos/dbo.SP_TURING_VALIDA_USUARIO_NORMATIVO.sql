USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TURING_VALIDA_USUARIO_NORMATIVO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TURING_VALIDA_USUARIO_NORMATIVO]
						( @usuario				 as varchar(20),
						  @sistema				 as varchar(03),
						  @producto				 as varchar(04),	
                          @Libro                 as Varchar(10),
						  @cartera_normativa	 as char(06),
						  @subcartera            as char(06),
                          @Existe			     as varchar(01) OUTPUT)
AS 
BEGIN

 BEGIN TRY 

     SET NOCOUNT ON

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


  if exists(select * from bacparamsuda..TBL_REL_USUARIO_NORMATIVO
   where         ucn_Usuario    = @usuario
   AND           UCn_SISTEMA    = @sistema
   and			 UCn_PRODUCTO   = @producto
   and           Ucn_Codigo_Lib = @Libro
   and           Ucn_Codigo_CartN = @cartera_normativa
   and           Ucn_Codigo_SubCartN = @subcartera
   /* and           UCn_default    = 'S' */ )

       begin
            select @Existe='S'
       end
       else
       begin
            select @Existe='N'
       end
       RETURN
 END TRY

 BEGIN CATCH
    -- Caida => no existe
    select @Existe='N'
    RETURN
 END CATCH
 END
GO
