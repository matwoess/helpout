PGDMP     ;                    y           helpout    12.7    12.7     (           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            )           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            *           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            +           1262    32777    helpout    DATABASE     �   CREATE DATABASE helpout WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'German_Germany.1252' LC_CTYPE = 'German_Germany.1252';
    DROP DATABASE helpout;
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
    "timestamp" timestamp without time zone,
    content character varying
);
    DROP TABLE public.message;
       public         heap    postgres    false            �            1259    32799    user    TABLE     7  CREATE TABLE public."user" (
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
       public         heap    postgres    false            #          0    32807    chat 
   TABLE DATA                 public          postgres    false    205   N       !          0    32791    city 
   TABLE DATA                 public          postgres    false    203   H                  0    32786    gender 
   TABLE DATA                 public          postgres    false    202   �       $          0    32815    message 
   TABLE DATA                 public          postgres    false    206   7       "          0    32799    user 
   TABLE DATA                 public          postgres    false    204   �       ,           0    0    chat_chatid_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.chat_chatid_seq', 1, false);
          public          postgres    false    207            �
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
           2606    49174    message message_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (chatid, msgid);
 >   ALTER TABLE ONLY public.message DROP CONSTRAINT message_pkey;
       public            postgres    false    206    206            �
           2606    32806    user user_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (username);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public            postgres    false    204            �
           2606    32853    message chatid_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.message
    ADD CONSTRAINT chatid_fk FOREIGN KEY (chatid) REFERENCES public.chat(chatid) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 ;   ALTER TABLE ONLY public.message DROP CONSTRAINT chatid_fk;
       public          postgres    false    205    2714    206            �
           2606    32828    user gid_fk    FK CONSTRAINT     t   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT gid_fk FOREIGN KEY (gid) REFERENCES public.gender(gid) NOT VALID;
 7   ALTER TABLE ONLY public."user" DROP CONSTRAINT gid_fk;
       public          postgres    false    2708    204    202            �
           2606    32838    chat username1_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username1_fk FOREIGN KEY (username1) REFERENCES public."user"(username) NOT VALID;
 ;   ALTER TABLE ONLY public.chat DROP CONSTRAINT username1_fk;
       public          postgres    false    204    2712    205            �
           2606    32843    chat username2_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username2_fk FOREIGN KEY (username2) REFERENCES public."user"(username) NOT VALID;
 ;   ALTER TABLE ONLY public.chat DROP CONSTRAINT username2_fk;
       public          postgres    false    2712    205    204            �
           2606    32833    user zip_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT zip_fk FOREIGN KEY (zipcode) REFERENCES public.city(zipcode) NOT VALID;
 7   ALTER TABLE ONLY public."user" DROP CONSTRAINT zip_fk;
       public          postgres    false    203    204    2710            #   �   x�ŒOk�@���s�BXj��Th����BOe�L����9��w�4�ԣ���>X�=~�xQ�e���pv�(�lߡ��e�&i4�?�!�������a��˒��b�{U�ؽ���Y��)�O<J >��uRYұW����7�x����vt��вm�%f�H��4�><�캍=����<>�t�`Q��ډ����^%��烽3z�f�<������e�fC
T
�?8D�7�Wu&      !   w   x���v
Q���W((M��L�K�,�TШ�,H�OI�Q�K�M�Ts�	uV�0102�QP��̫R״��$Y�1e�M(�n
�R�X�G�~##C�����ʢ��t��03 9!<5���� �r          X   x���v
Q���W((M��L�KO�KI-R�H�L�Q�K�M�Ts�	uV�0�QP�u�qU״��$I�P��+yz��z�C<\�@Z�� {v2�      $   ^  x����J�0��=���AW����PX�	n:��t�a�4ImRe�ݴsL���
!!��8?i4���fMf�PT˜%.G��B/�b�R�Z�C��1G:��M:�EǁD
�B�����y<�����|��;�5S�Q2���x���W/�c�K8�H�a�֛����e+��"'���A�+b���S$_Lg�$G�1�r�NVy
kYA�y1����.�5u5����}?_Q9�����y�G=����37%@!rZ���E)�9r������@L����^5�^�b���Tn�?��T������5��em�� G^���_���w|��qd��c�~ø��7�V���      "   
  x��V�n�0}�W}i+-�M�R
OEl�E�H݅'$�$��%�#_Z���'�cg�V��k�V�x��>s���j�����j�	��<��A}��&��\ۅ5�F�n��#��d�7�+9���#�ɛL����z&SO�������(�*.-�}P���W!��.�܄Ra3f��2mƂ�G�,��k`TX7���Am��h&�l�LBON���j^��b ���}�AJK�U��_���x|��V�LrJ5�Pg�dX���J�].s�t�|�N	.K�>Of�C��G5��E�U � B9ʌ���A������Ť�=��[Ds��/�tX)�R�3�z��J+�)%f��]hD�\�S��٠(-�7,*�K;�[?���>�j�|��7I��`�\�l׬��{3����=��4 -�{״&�.c~D�p��+1|�����
42z4�`
�R8�]�C���H�pI{.�E�=�*gA dLB�P(GoЄh�Sj�������x��FUZ4���b1hٝ�q2�<��2�Z��'��ग�Ec۾��R=^�r�Gj��Aa1G���`�t�rl����}���<��xO6�m����;_�TJv�����6	���>���5� �tE�V9M�B���;��.N����[�Bh��_-2����@�7@?j�F����VHM��;^�`�.��n�Ep���)PM�x(�ʁ�F�1��諼P�S_hjd�\AI�2oQ��UC��i�Kq	d0dA�Q�<hk��i�up��'K9     