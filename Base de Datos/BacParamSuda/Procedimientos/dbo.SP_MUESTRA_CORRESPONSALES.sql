USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MUESTRA_CORRESPONSALES]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MUESTRA_CORRESPONSALES]  
   (   @moneda   NUMERIC(05)  
   ,   @tipo  CHAR(01)    = 'A'  
   ,   @codigo  NUMERIC(10) = 0  
   )  
as  
begin  
  
   set nocount on  
  
   declare @Rut_Banco   numeric(10)  
       set @Rut_Banco   = ( select acrutprop from view_mdac )  
  
   if @tipo = 'A'   
   begin  
      select    cod_corresponsal   --> codigo_contable  
          ,     nombre  
      from      BacParamSuda.dbo.corresponsal   
      where     rut_cliente      = @rut_banco  
      and       codigo_moneda    = @moneda  
      and       codigo_contable  <> 0  
   and  cod_corresponsal <> 0   
      order by  cod_corresponsal  
  
   end else  
   begin  
      select    cod_corresponsal   --> codigo_contable  
          ,     nombre  
      from      BacParamSuda.dbo.corresponsal   
      where     rut_cliente      = @rut_banco  
      and       codigo_moneda  = @moneda  
      and       cod_corresponsal = @codigo --> codigo_contable = @codigo  
      order by  cod_corresponsal  
  
   end  
  
END
GO
