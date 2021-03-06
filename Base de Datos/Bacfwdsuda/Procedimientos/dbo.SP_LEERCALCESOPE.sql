USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERCALCESOPE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_LEERCALCESOPE]
   (   @nproducto    NUMERIC(2,0)
   ,   @nmoneda1     NUMERIC(3,0)
   ,   @dvencimiento CHAR(8)
   ,   @ctipoper     CHAR(1)
   ,   @nopercalze   NUMERIC(10,0)
   )
AS
BEGIN
   SET NOCOUNT ON

   BEGIN TRANSACTION

   IF @nproducto = 10
   BEGIN
      RETURN
   END

   IF @nproducto = 1 OR @nproducto = 7 /* Producto Seguro de Cambio */
   BEGIN
      IF @ctipoper='C'
      BEGIN
         SELECT b.clnombre                            ,
                c.descripcion                         ,
                d.mnnemo                              ,
                a.camtomon1                           ,
                a.canumoper                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopevta = a.canumoper AND
                         ccopecmp = @nopercalze )     ,
                a.cacodpos1                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopevta = a.canumoper )
         FROM   MFCA          a,
                VIEW_CLIENTE  b,
                view_producto c,
                VIEW_MONEDA   d
         WHERE (a.cacodpos1       = 1             OR
                a.cacodpos1       = 4             OR
                a.cacodpos1       = 6             OR
                a.cacodpos1       = 7             OR
                a.cacodpos1       = 5 )           AND
                CONVERT(CHAR(8),a.cafecvcto,112) = @dvencimiento AND
               (a.catipoper       = 'V'           OR
                a.catipoper       = 'A')          AND
                a.cacodmon1       = d.mncodmon    AND
               (a.cacodigo        = b.clrut       AND
                a.cacodcli        = b.clcodigo)   AND
               (c.id_sistema      = 'BFW'         AND
                c.codigo_producto = a.cacodpos1)

      END ELSE
      BEGIN

         SELECT b.clnombre                            ,
                c.descripcion                         ,
                d.mnnemo                              ,
                a.camtomon1                           ,
                a.canumoper                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopecmp = a.canumoper AND
                         ccopevta = @nopercalze )     ,
                a.cacodpos1                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopecmp = a.canumoper )
         FROM   MFCA          a,
                VIEW_CLIENTE  b,
                view_producto c,
                VIEW_MONEDA   d
         WHERE (a.cacodpos1       = 1             OR
                a.cacodpos1       = 4             OR
                a.cacodpos1       = 6             OR
                a.cacodpos1       = 7             OR
                a.cacodpos1       = 5 )           AND
                CONVERT(CHAR(8),a.cafecvcto,112) = @dvencimiento AND
               (a.catipoper       = 'C'           OR
                a.catipoper       = 'O' )         AND
                a.cacodmon1       = d.mncodmon    AND
               (a.cacodigo        = b.clrut      AND
                a.cacodcli   = b.clcodigo)   AND
                c.id_sistema      = 'BFW'         AND
                c.codigo_producto = a.cacodpos1
       END

   END ELSE IF @nproducto = 3 /*== Producto Seguro Inflacion ==*/
   BEGIN
          
      IF @ctipoper = 'C'
      BEGIN
         SELECT b.clnombre                            ,
                c.descripcion                         ,
                d.mnnemo                              ,
                a.camtomon1                           ,
                a.canumoper                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
         WHERE  ccopevta = a.canumoper AND
                         ccopecmp = @nopercalze )      ,
                a.cacodpos1                            ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE ccopevta = a.canumoper )
         FROM   MFCA          a,
                VIEW_CLIENTE  b,
                view_producto c,
                VIEW_MONEDA   d
         WHERE  a.cacodpos1       = 3             AND
                CONVERT(CHAR(8),a.cafecvcto,112) = @dvencimiento AND
                ( a.catipoper     = 'V'           OR
                  a.catipoper     = 'A' )         AND
                a.cacodmon1       = d.mncodmon    AND
                (a.cacodigo        = b.clrut      AND
  a.cacodcli   = b.clcodigo)   AND
                c.id_sistema      = 'BFW'         AND
                c.codigo_producto = a.cacodpos1
      END
      ELSE
      BEGIN
         SELECT b.clnombre                            ,
                c.descripcion                         ,
                d.mnnemo                              ,
                a.camtomon1                           , 
                a.canumoper                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopecmp = a.canumoper AND
                         ccopevta = @nopercalze )     ,
                a.cacodpos1                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopecmp = a.canumoper )
         FROM   MFCA          a,
                VIEW_CLIENTE  b,
                view_producto c,
                VIEW_MONEDA   d
         WHERE  a.cacodpos1   = 3              AND
                CONVERT(CHAR(8),a.cafecvcto,112) = @dvencimiento AND
                ( a.catipoper = 'C'            OR
                  a.catipoper = 'O' )          AND
                a.cacodmon1   = d.mncodmon     AND
                (a.cacodigo        = b.clrut      AND
  a.cacodcli   = b.clcodigo)   AND
                c.id_sistema      = 'BFW'         AND
                c.codigo_producto = a.cacodpos1
      END
   END
   ELSE IF @nproducto = 4 OR @nproducto = 6 /* Producto Operaciones Sinteticas */
   BEGIN
      IF @ctipoper = 'C'
      BEGIN
         SELECT b.clnombre                            ,
                c.descripcion                         ,
                d.mnnemo                              ,
                a.camtomon1                           ,
                a.canumoper                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopevta = a.canumoper AND
                         ccopecmp = @nopercalze )     ,
                a.cacodpos1                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE ccopevta = a.canumoper ) 
         FROM   MFCA          a,
                VIEW_CLIENTE  b,
                view_producto c,
                VIEW_MONEDA   d
         WHERE  ( a.cacodpos1     = 1             OR
                  a.cacodpos1     = 4             OR
                  a.cacodpos1     = 6             OR
                  a.cacodpos1     = 7             OR
                  a.cacodpos1     = 5 )           AND
                CONVERT(CHAR(8),a.cafecvcto,112) = @dvencimiento AND
                ( a.catipoper     = 'V'           OR
                  a.catipoper     = 'A' )         AND
                a.cacodmon1       = d.mncodmon    AND
                (a.cacodigo        = b.clrut      AND
  a.cacodcli   = b.clcodigo)   AND
                c.id_sistema      = 'BFW'         AND
c.codigo_producto = a.cacodpos1
      END
      ELSE
      BEGIN
         SELECT b.clnombre                      ,
                c.descripcion                         ,
                d.mnnemo                              ,
                a.camtomon1                           ,
                a.canumoper                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopecmp = a.canumoper AND
                         ccopevta = @nopercalze )     ,
                a.cacodpos1                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopecmp = a.canumoper )  
         FROM   MFCA          a,
                VIEW_CLIENTE  b,
                view_producto c,
                VIEW_MONEDA   d   
         WHERE  ( a.cacodpos1     = 1             OR
                  a.cacodpos1     = 4             OR
                  a.cacodpos1     = 6             OR
                  a.cacodpos1     = 7             OR
                  a.cacodpos1     = 5 )           AND
                CONVERT(CHAR(8),a.cafecvcto,112) = @dvencimiento AND
                ( a.catipoper     = 'C'           OR
                  a.catipoper     = 'O' )         AND
                a.cacodmon1       = d.mncodmon    AND
                (a.cacodigo        = b.clrut      AND
  a.cacodcli   = b.clcodigo)   AND
                c.id_sistema      = 'BFW'         AND
                c.codigo_producto = a.cacodpos1
 
      END
   END
   ELSE IF @nproducto = 5 /* Producto Operaciones 1446*/
   BEGIN
      IF @ctipoper = 'O'
      BEGIN
         SELECT b.clnombre                            ,
                c.descripcion                         ,
                d.mnnemo                              ,
                a.camtomon1                           ,
                a.canumoper                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopevta = a.canumoper AND
                         ccopecmp = @nopercalze)      ,
                a.cacodpos1                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopevta = a.canumoper )   
         FROM   MFCA          a,
                VIEW_CLIENTE  b,
                view_producto c,
                VIEW_MONEDA   d
         WHERE  ( a.cacodpos1     = 1             OR
                  a.cacodpos1     = 4 )           AND
                CONVERT(CHAR(8),a.cafecvcto,112) = @dvencimiento AND
                ( a.catipoper     = 'V'           OR
                  a.catipoper     = 'A' )         AND
                a.cacodmon1       = d.mncodmon    AND
                (a.cacodigo        = b.clrut      AND
  a.cacodcli   = b.clcodigo)   AND
                c.id_sistema      = 'BFW'         AND
                c.codigo_producto = a.cacodpos1
               
      END
      BEGIN
                 
         SELECT b.clnombre                            ,
                c.descripcion                         ,
                d.mnnemo                              ,
                a.camtomon1                           ,
                a.canumoper                           ,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopecmp = a.canumoper AND
                         ccopevta = @nopercalze )     ,
                a.cacodpos1,
                ( SELECT ISNULL ( SUM ( ccmonto ), 0 )
                  FROM   MFCC
                  WHERE  ccopecmp = a.canumoper )
         FROM   MFCA          a,
                VIEW_CLIENTE  b,
                view_producto c,
                VIEW_MONEDA   d
         WHERE  ( a.cacodpos1     = 1             OR
                  a.cacodpos1  = 4 )           AND
                CONVERT(CHAR(8),a.cafecvcto,112) = @dvencimiento AND
   ( a.catipoper     = 'C'           OR
            a.catipoper     = 'O' )         AND
                  a.cacodmon1       = d.mncodmon    AND
                (a.cacodigo        = b.clrut      AND
                 a.cacodcli   = b.clcodigo)   AND
                 c.id_sistema      = 'BFW'         AND
                 c.codigo_producto = a.cacodpos1
      END
   END

   -- ********************************************************************** --
   -- Agregado el dia Viernes 29/10/2004, para agregar los calces de Forward --
   -- ********************************************************************** --
   IF @nproducto = 2 /* Producto Arbitraje futuro */
   BEGIN
      IF @ctipoper='C'
      BEGIN
         SELECT b.clnombre                            
         ,      c.descripcion                         
         ,      d.mnnemo                              
         ,      a.camtomon1                           
         ,      a.canumoper                           
         ,     (SELECT ISNULL ( SUM ( ccmonto ), 0 ) FROM MFCC WHERE ccopevta = a.canumoper AND ccopecmp = @nopercalze )     
         ,      a.cacodpos1                           
         ,     (SELECT ISNULL ( SUM ( ccmonto ), 0 ) FROM MFCC WHERE ccopevta = a.canumoper )
         FROM   MFCA          a
         ,      VIEW_CLIENTE  b
         ,      view_producto c
         ,      VIEW_MONEDA   d
         WHERE (a.cacodpos1       = 2)
         AND    CONVERT(CHAR(8),a.cafecvcto,112) = @dvencimiento 
         AND    a.catipoper       = 'V' 
         AND    a.cacodmon1       = d.mncodmon    
         AND   (a.cacodigo        = b.clrut AND a.cacodcli        = b.clcodigo)   
         AND   (c.id_sistema      = 'BFW'   AND c.codigo_producto = a.cacodpos1)
      END ELSE
      BEGIN
         SELECT b.clnombre                            
         ,      c.descripcion                         
         ,      d.mnnemo                              
         ,      a.camtomon1                           
         ,      a.canumoper                           
         ,     (SELECT ISNULL ( SUM ( ccmonto ), 0 ) FROM MFCC WHERE ccopecmp = a.canumoper AND ccopevta = @nopercalze )     
         ,      a.cacodpos1                           
         ,     (SELECT ISNULL ( SUM ( ccmonto ), 0 ) FROM MFCC WHERE ccopecmp = a.canumoper )
         FROM   MFCA          a
         ,      VIEW_CLIENTE  b
         ,      view_producto c
         ,      VIEW_MONEDA   d
         WHERE (a.cacodpos1       = 2)           
         AND    CONVERT(CHAR(8),a.cafecvcto,112) = @dvencimiento 
         AND    a.catipoper       = 'C'
         AND    a.cacodmon1       = d.mncodmon    
         AND   (a.cacodigo        = b.clrut      
         AND    a.cacodcli        = b.clcodigo)   
         AND    c.id_sistema      = 'BFW'         
         AND    c.codigo_producto = a.cacodpos1
       END
   END 


   IF @@error <> 0 
   BEGIN
      ROLLBACK TRANSACTION
      SELECT -1, 'Error: en la lectura.'
      SET NOCOUNT OFF
      RETURN
   END

   COMMIT TRANSACTION
   SET NOCOUNT OFF

END


GO
