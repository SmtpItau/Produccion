USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_CORRESP_VCTO_ARB_FWD]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_CORRESP_VCTO_ARB_FWD]  
   (   @Correla               NUMERIC(10)  
   ,   @Moneda        NUMERIC(10)  
   ,   @Tipo        CHAR(01)  
   ,   @Codigo_Corresponsal   NUMERIC(10)  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   declare @ncodigo_contable    numeric(10)  
       set @ncodigo_contable    = ( select top 1 codigo_contable   
                                      from BacParamSuda.dbo.corresponsal   
                                     where cod_corresponsal = @Codigo_Corresponsal )  
  
   insert into dbo.arb_fwd_corresponsal   
   (    CoCorrela  
   ,    CoMoneda  
   ,    CoTipo_Op  
   ,    CoCodigo_Contable  
   )  
   values                      --( @Correla,  @Moneda,  @Tipo,     @ncodigo_contable )  
   (    @Codigo_Corresponsal   
   ,    @Moneda  
   ,    @Tipo  
   ,    @ncodigo_contable   
   )  
  
   if @@Error <> 0   
   begin  
      select 'NO' AS RESULTADO  
      return -1  
   end  
  
   select 'OK' AS RESULTADO  
   return  0  
  
END

GO
