PGDMP     5    
                y           help_out    12.3    12.3     +           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ,           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            -           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            .           1262    32777    help_out    DATABASE     �   CREATE DATABASE help_out WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'German_Germany.1252' LC_CTYPE = 'German_Germany.1252';
    DROP DATABASE help_out;
                postgres    false            �            1259    32807    chat    TABLE     �   CREATE TABLE public.chat (
    chatid integer NOT NULL,
    isread boolean,
    username1 character varying NOT NULL,
    username2 character varying NOT NULL
);
    DROP TABLE public.chat;
       public         heap    postgres    false            �            1259    40969    chat_chatid_seq    SEQUENCE     �   ALTER TABLE public.chat ALTER COLUMN chatid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.chat_chatid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    205            �            1259    32791    city    TABLE     W   CREATE TABLE public.city (
    zipcode integer NOT NULL,
    name character varying
);
    DROP TABLE public.city;
       public         heap    postgres    false            �            1259    32786    gender    TABLE     X   CREATE TABLE public.gender (
    gid integer NOT NULL,
    name character varying(8)
);
    DROP TABLE public.gender;
       public         heap    postgres    false            �            1259    32815    message    TABLE     �   CREATE TABLE public.message (
    chatid integer NOT NULL,
    msgid integer NOT NULL,
    username character varying NOT NULL,
    "timestamp" timestamp with time zone,
    content character varying
);
    DROP TABLE public.message;
       public         heap    postgres    false            �            1259    40971    message_msgid_seq    SEQUENCE     �   ALTER TABLE public.message ALTER COLUMN msgid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.message_msgid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    206            �            1259    32799    user    TABLE     7  CREATE TABLE public."user" (
    username character varying NOT NULL,
    firstname character varying NOT NULL,
    lastname character varying NOT NULL,
    price real,
    asset character varying,
    description character varying,
    gid integer,
    zipcode integer,
    level integer,
    score integer
);
    DROP TABLE public."user";
       public         heap    postgres    false            %          0    32807    chat 
   TABLE DATA                 public          postgres    false    205   �       #          0    32791    city 
   TABLE DATA                 public          postgres    false    203   �       "          0    32786    gender 
   TABLE DATA                 public          postgres    false    202          &          0    32815    message 
   TABLE DATA                 public          postgres    false    206   �       $          0    32799    user 
   TABLE DATA                 public          postgres    false    204   �        /           0    0    chat_chatid_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.chat_chatid_seq', 1, false);
          public          postgres    false    207            0           0    0    message_msgid_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.message_msgid_seq', 1, false);
          public          postgres    false    208            �
           2606    32814    chat chat_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_pkey PRIMARY KEY (chatid);
 8   ALTER TABLE ONLY public.chat DROP CONSTRAINT chat_pkey;
       public            postgres    false    205            �
           2606    32798    city city_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (zipcode);
 8   ALTER TABLE ONLY public.city DROP CONSTRAINT city_pkey;
       public            postgres    false    203            �
           2606    32790    gender gender_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.gender
    ADD CONSTRAINT gender_pkey PRIMARY KEY (gid);
 <   ALTER TABLE ONLY public.gender DROP CONSTRAINT gender_pkey;
       public            postgres    false    202            �
           2606    32822    message message_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (chatid, msgid, username);
 >   ALTER TABLE ONLY public.message DROP CONSTRAINT message_pkey;
       public            postgres    false    206    206    206            �
           2606    32806    user user_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (username);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public            postgres    false    204            �
           2606    32853    message chatid_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.message
    ADD CONSTRAINT chatid_fk FOREIGN KEY (chatid) REFERENCES public.chat(chatid) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ;   ALTER TABLE ONLY public.message DROP CONSTRAINT chatid_fk;
       public          postgres    false    2716    205    206            �
           2606    32828    user gid_fk    FK CONSTRAINT     t   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT gid_fk FOREIGN KEY (gid) REFERENCES public.gender(gid) NOT VALID;
 7   ALTER TABLE ONLY public."user" DROP CONSTRAINT gid_fk;
       public          postgres    false    2710    202    204            �
           2606    32838    chat username1_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username1_fk FOREIGN KEY (username1) REFERENCES public."user"(username) NOT VALID;
 ;   ALTER TABLE ONLY public.chat DROP CONSTRAINT username1_fk;
       public          postgres    false    2714    204    205            �
           2606    32843    chat username2_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username2_fk FOREIGN KEY (username2) REFERENCES public."user"(username) NOT VALID;
 ;   ALTER TABLE ONLY public.chat DROP CONSTRAINT username2_fk;
       public          postgres    false    2714    204    205            �
           2606    32833    user zip_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT zip_fk FOREIGN KEY (zipcode) REFERENCES public.city(zipcode) NOT VALID;
 7   ALTER TABLE ONLY public."user" DROP CONSTRAINT zip_fk;
       public          postgres    false    204    2712    203            %   �   x�ŒOk�@���s�BXj��Th����BOe�L����9��w�4�ԣ���>X�=~�xQ�e���pv�(�lߡ��e�&i4�?�!�������a��˒��b�{U�ؽ���Y��)�O<J >��uRYұW����7�x����vt��вm�%f�H��4�><�캍=����<>�t�`Q��ډ����^%��烽3z�f�<������e�fC
T
�?8D�7�Wu&      #   w   x���v
Q���W((M��L�K�,�TШ�,H�OI�Q�K�M�Ts�	uV�0102�QP��̫R״��$Y�1e�M(�n
�R�X�G�~##C�����ʢ��t��03 9!<5���� �r      "   X   x���v
Q���W((M��L�KO�KI-R�H�L�Q�K�M�Ts�	uV�0�QP�u�qU״��$I�P��+yz��z�C<\�@Z�� {v2�      &   @  x�ŒQk�0���g2PY-i�7&c+[`S�N�Qۋ�h��I7d�/*2܃��AH�����Ça0��'#�2�bW��ъЌ��d��W���T�H����l��DQw+iH�F�`<�w|x�pN�'Lo���������K[���ڬ��{�X���>�`����\��S��Jw��u�h]��I��? ���%�UYI����8>2�B+A&���]�[U�	֪BJy18�&ߢ�*r-�����/�I;�UIg�N��9�j��~Pgv:4��0
K��R-s��r�xr�6sH�d�]`��i�,�,%�D��[Yh��V�C� ^      $   �  x��V�n�0}�W}i+-�M�R
OEl�"Z���r�I�ۑ/-�{�~����V��k�V��8�}�9��z�����z�	��<��A}��"��\ۅ5�F�.��#��d�7�+9���#�ɛL����z&SO������5�*�*.-�}P���/C6E]��	��*f��eڌ�1�Y��W�0��n
WC��(�L<��$�� ���9X6ռ,��( |K#n-�x���&��߿:����q����6j��:�ɰP1ϕ�\��\��\�><}�̤����jVC�4� �A�r��5Ds������=ŋI�{:��*�:1_1�Rަ�gH����V�SJ�Z�Ј`���(g�AQZ&oYTj�vP7~��}��>�&��o����4�*%ضY��;3���ю�+�罂kZs�1��U	���KVbx)�'�hdtkP�7�pһ�!�T+[����
\J��},U΂@Ș��P���	��=��(Tg�����xk�$�,�h0�y���bв;��d�x.�e\�B9O��C�I/%�1�ƶ}���z��	妏�'��b�d#��\��2��r������5xr���l&����O��0���l��'�!�-V�3�}g=�$A
$���r�z�l?7/�@{\�k���~���mk7�{r�n*n�~Ԟ�V��\"5�
�y]�E��6uk�.���L�jB�C�T\4��MG_�� ��BS#3�
JZ�y���e�=��r98���:�     