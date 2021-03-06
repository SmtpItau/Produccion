USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_CUENTA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_GRABAR_CUENTA](@cuenta            char(11)        ,
         @descripcion       char(70)        ,
        @glosa  char(30) ,
                             @tipcuenta  char(3)  ,
        @cta_imp  char(1)  ,
        @con_correc char(1)  ,
        @con_cto_costo char(1)  ,
        @tipo_mon          char( 1) ,
                             @prod_asoc  numeric( 5)     ,
                             @cta_sbif          numeric( 4) ,
                             @tipo_saldo numeric( 3) ,
        @tipo_relacion numeric (3) )
as 
begin
     ----<< agrega
     if not exists(select * from VIEW_PLAN_DE_CUENTAS where cuenta = @cuenta)
     begin
          insert into VIEW_PLAN_DE_CUENTAS 
--               values(@cuenta, @descripcion , @glosa, @tipo_mon,@prod_asoc,@cta_sbif,@tipo_saldo,@tipo_relacion,'')
  values( @cuenta ,
   @descripcion,
   @glosa,
   @tipcuenta,
   @cta_imp,
   @con_correc ,
   @con_cto_costo, 
   @tipo_mon     ,  
                        @prod_asoc, 
                        @cta_sbif , 
                        @tipo_saldo,
   @tipo_relacion )
          if @@error <> 0 
          begin
               select -1,'no se pudo agregar al plan de cuentas'
               return
          end
     end
     ----<< actualiza
     update VIEW_PLAN_DE_CUENTAS set 
         descripcion = @descripcion ,
        glosa  = @glosa ,
        tipo_cuenta   = ''   ,
        cuenta_imputable='',
        con_correccion='',
        con_centro_costo='', 
        tipo_moneda = @tipo_mon ,
                             prod_asoc   = @prod_asoc ,
                             cta_sbif   = @cta_sbif  ,
                             tipo_saldo  = @tipo_saldo,
        tipo_relacion = @tipo_relacion
   
   
   
   
   
                           
                           where cuenta = @cuenta
     if @@error <> 0 
     begin
          select -1,'no se pudo actualizar cuenta'
          return
     end
  
end 

GO
