PGDMP         &    	            y           helpout    12.7    12.7     %           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            &           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            '           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            (           1262    57354    helpout    DATABASE     ?   CREATE DATABASE helpout WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'German_Germany.1252' LC_CTYPE = 'German_Germany.1252';
    DROP DATABASE helpout;
                helpout    false            ?            1259    57355    chat    TABLE     ?   CREATE TABLE public.chat (
    chatid integer NOT NULL,
    isread1 boolean,
    username1 character varying NOT NULL,
    username2 character varying NOT NULL,
    isread2 boolean
);
    DROP TABLE public.chat;
       public         heap    postgres    false            ?            1259    57361    city    TABLE     W   CREATE TABLE public.city (
    zipcode integer NOT NULL,
    name character varying
);
    DROP TABLE public.city;
       public         heap    postgres    false            ?            1259    57367    gender    TABLE     X   CREATE TABLE public.gender (
    gid integer NOT NULL,
    name character varying(8)
);
    DROP TABLE public.gender;
       public         heap    postgres    false            ?            1259    57370    message    TABLE     ?   CREATE TABLE public.message (
    chatid integer NOT NULL,
    msgid integer NOT NULL,
    username character varying NOT NULL,
    "timestamp" timestamp without time zone,
    content character varying
);
    DROP TABLE public.message;
       public         heap    postgres    false            ?            1259    57376    user    TABLE     v  CREATE TABLE public."user" (
    username character varying NOT NULL,
    firstname character varying NOT NULL,
    lastname character varying NOT NULL,
    price real,
    asset character varying,
    description character varying,
    gid integer,
    zipcode integer,
    level integer,
    score integer,
    password character varying NOT NULL,
    isassist boolean
);
    DROP TABLE public."user";
       public         heap    postgres    false                      0    57355    chat 
   TABLE DATA                 public          postgres    false    202   t                 0    57361    city 
   TABLE DATA                 public          postgres    false    203   \                  0    57367    gender 
   TABLE DATA                 public          postgres    false    204   ?       !          0    57370    message 
   TABLE DATA                 public          postgres    false    205   W       "          0    57376    user 
   TABLE DATA                 public          postgres    false    206   ?       ?
           2606    57383    chat chat_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_pkey PRIMARY KEY (chatid);
 8   ALTER TABLE ONLY public.chat DROP CONSTRAINT chat_pkey;
       public            postgres    false    202            ?
           2606    57385    city city_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (zipcode);
 8   ALTER TABLE ONLY public.city DROP CONSTRAINT city_pkey;
       public            postgres    false    203            ?
           2606    57387    gender gender_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.gender
    ADD CONSTRAINT gender_pkey PRIMARY KEY (gid);
 <   ALTER TABLE ONLY public.gender DROP CONSTRAINT gender_pkey;
       public            postgres    false    204            ?
           2606    57389    message message_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (chatid, msgid);
 >   ALTER TABLE ONLY public.message DROP CONSTRAINT message_pkey;
       public            postgres    false    205    205            ?
           2606    57391    user user_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (username);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public            postgres    false    206            ?
           2606    57392    message chatid_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.message
    ADD CONSTRAINT chatid_fk FOREIGN KEY (chatid) REFERENCES public.chat(chatid) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ;   ALTER TABLE ONLY public.message DROP CONSTRAINT chatid_fk;
       public          postgres    false    205    202    2706            ?
           2606    57397    user gid_fk    FK CONSTRAINT     t   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT gid_fk FOREIGN KEY (gid) REFERENCES public.gender(gid) NOT VALID;
 7   ALTER TABLE ONLY public."user" DROP CONSTRAINT gid_fk;
       public          postgres    false    204    206    2710            ?
           2606    57402    chat username1_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username1_fk FOREIGN KEY (username1) REFERENCES public."user"(username) NOT VALID;
 ;   ALTER TABLE ONLY public.chat DROP CONSTRAINT username1_fk;
       public          postgres    false    206    2714    202            ?
           2606    57407    chat username2_fk    FK CONSTRAINT     ?   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username2_fk FOREIGN KEY (username2) REFERENCES public."user"(username) NOT VALID;
 ;   ALTER TABLE ONLY public.chat DROP CONSTRAINT username2_fk;
       public          postgres    false    202    2714    206            ?
           2606    57412    user zip_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT zip_fk FOREIGN KEY (zipcode) REFERENCES public.city(zipcode) NOT VALID;
 7   ALTER TABLE ONLY public."user" DROP CONSTRAINT zip_fk;
       public          postgres    false    2708    206    203               ?   x???M?0?????Y #͌????e]??.?䊽??????y{?Ə??-Ym?M
?*]????HV???c??\I????QL
???4h??!??]????-???Ό?\h&?{U_?1??e8w??A??<?׿?Oʊ<n?oЭI???[?Ö?(*$?4?ϦO??kJ-?Q?%?`?_?iW`4ŽP??e?a?N%/
?QV??KG!pu2ǹ&Ng?         ?   x???v
Q???W((M??L?K?,?TШ?,H?OI?Q?K?M?Ts?	uV?0102?QP??̫R״??$Y?1e?M(?n
?R?X?G?~##C?????ʢ??t??03 9!<5??<?? 5?/%3?.. ?3?M          X   x???v
Q???W((M??L?KO?KI-R?H?L?Q?K?M?Ts?	uV?0?QP?u?qU״??$I?P??+yz??z?C<\?@Z?? {v2?      !   ?  x???]K?0?????!l??4??F????Lp?!?kk?Mf?*C?劣c"??&P(i??y?????q?l? ?j?g?U??a???
??_???EГ??$?b?3 ?L"?Cx????a`??~?{=??W?ԦĴ=?z@???j??w??.??L?????????jq?3\^?
???*+"!2?&?>3????4ck?ny?'????o'??T??8Z??????9????*??P??i??>?_?R? ?X??*gؖ|?c??_n{???a!0Ĥ?o??U??dŖ)2H?>??C?UU?h??7	Bk????R?????8| *Z? ~sz3}??9?q=??0>??4?h?/?u[nTߤN}??8 ?$?蔜?C?JF{???u???BϰPz?#?????      "   m  x?͖?r?6??~??llϨ?H?JӮҩ?S?3??Uf: yH"????a??o??Hʊg?	??~??????_??????_`B)x?=?s8?/?$.?????(?T2?W?bΡ_@????x??Z^/??n*]?!x?b??6???R??ȝ???_???rg?L)?r{???WT???G??RqK???[?;??u?%?Ɍjc߷Xi)Q? ??^?????Q?b??j???f{A?=?z??דݼ@???t>?mp?(???ؚ??±?p??b
:t??T???l?Z 6?QZ޶?c???~??>??#5+Wu???mR??SH?$B?!????(6?b5?h???X`]k?DPfk??k?U?/?=}<{1?}OY&?G???d0&GE@00?r???`??dY?g????+?Dp????F0??*??h?????HL??2M?:?&?b???fCf?k???alʿ?"?<?c1A(O|?Hc??t??cIl6????3??H???#?8\"?w4#Ȟ6?.?\?E??=<҃??Qe?P4?&5m???}C?Z?k??X?M?|ޫ?ڂ?=W???ų??B??gٰͅ?\?;?Z????+?Mj?r.>?r;o?L}`YkC9(?6?c?????S?)?JN??G?; ???D??M?.9?Xk)R)K???NC&^E????<?ޗ? F-?x???F???d?<??
????????:T???%???+RX?????&?uM&???)????J??fp?X?c:`??(??h}???cI?
	?C???e?m?_??,??Ũ?????͋?????ߛ^?#??!"?sѢ[?4??r???Ωm}?Ǽ?u?????ǿQ??HC???]???]	<?z;?:u????C??|??|     