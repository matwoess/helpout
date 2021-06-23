PGDMP                         y           helpout    12.7    12.7     %           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            &           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            '           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            (           1262    32777    helpout    DATABASE     �   CREATE DATABASE helpout WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'German_Germany.1252' LC_CTYPE = 'German_Germany.1252';
    DROP DATABASE helpout;
                postgres    false            �            1259    32807    chat    TABLE     �   CREATE TABLE public.chat (
    chatid integer NOT NULL,
    isread boolean,
    username1 character varying NOT NULL,
    username2 character varying NOT NULL
);
    DROP TABLE public.chat;
       public         heap    postgres    false            �            1259    32791    city    TABLE     W   CREATE TABLE public.city (
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
       public         heap    postgres    false            �            1259    32799    user    TABLE     �  CREATE TABLE public."user" (
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
    requestassist boolean NOT NULL
);
    DROP TABLE public."user";
       public         heap    postgres    false            !          0    32807    chat 
   TABLE DATA                 public          postgres    false    205   m                 0    32791    city 
   TABLE DATA                 public          postgres    false    203   H                 0    32786    gender 
   TABLE DATA                 public          postgres    false    202   �       "          0    32815    message 
   TABLE DATA                 public          postgres    false    206   7                  0    32799    user 
   TABLE DATA                 public          postgres    false    204   �       �
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
       public          postgres    false    2712    206    205            �
           2606    32828    user gid_fk    FK CONSTRAINT     t   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT gid_fk FOREIGN KEY (gid) REFERENCES public.gender(gid) NOT VALID;
 7   ALTER TABLE ONLY public."user" DROP CONSTRAINT gid_fk;
       public          postgres    false    2706    202    204            �
           2606    32838    chat username1_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username1_fk FOREIGN KEY (username1) REFERENCES public."user"(username) NOT VALID;
 ;   ALTER TABLE ONLY public.chat DROP CONSTRAINT username1_fk;
       public          postgres    false    204    205    2710            �
           2606    32843    chat username2_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username2_fk FOREIGN KEY (username2) REFERENCES public."user"(username) NOT VALID;
 ;   ALTER TABLE ONLY public.chat DROP CONSTRAINT username2_fk;
       public          postgres    false    204    2710    205            �
           2606    32833    user zip_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT zip_fk FOREIGN KEY (zipcode) REFERENCES public.city(zipcode) NOT VALID;
 7   ALTER TABLE ONLY public."user" DROP CONSTRAINT zip_fk;
       public          postgres    false    2708    203    204            !   �   x��һ�0����$������@b0t5��@�����[�[Y�s��_��e�_kT���4y�7=(�+k#Ĥ�`v-��0��W&!��η�BA!%4��O�v}S��������YH wB*������	q��,����t�@��@�;�H���j�9v���Xi�(�Wk~�ti�#�A���%��uLQ,g��>�b8h         w   x���v
Q���W((M��L�K�,�TШ�,H�OI�Q�K�M�Ts�	uV�0102�QP��̫R״��$Y�1e�M(�n
�R�X�G�~##C�����ʢ��t��03 9!<5���� �r         X   x���v
Q���W((M��L�KO�KI-R�H�L�Q�K�M�Ts�	uV�0�QP�u�qU״��$I�P��+yz��z�C<\�@Z�� {v2�      "   �  x���]K�0�����!l��4��F����Lp�!�kk�Mf�*C�劣c"��&P(i��y�����q�l� �j�g�U��a���
��_���EГ��$�b�3 �L"�Cx����a`��~�{=��W�ԦĴ=�z@���j��w��.��L��������jq�3\^�
���*+"!2�&�>3����4ck�ny�'����o'��T��8Z�����9����*��P��i��>�_�R� �X��*gؖ|�c��_n{��a!0Ĥ�o��U��dŖ)2H�>��C�UU�h��7	Bk����R����8| *Z? ~sz3}��9�q=��0>��4�h�/�u[nTߤN}��8 �$�蔜�C�JF{���u���BϰPz�#�����          D  x��V�n�0}�W}�V
��fwKᩈ�.�EbOH�I&�Kl_Z���'�c'i+�}�%���3g���rw��
��W�uY��x���p�?�	����ؾٰ��j�Ӈ�6�M�yk��T���'osU�)x�M&W�O�	�J� ��K}n�!|>y��t3��5�+�2ԳfW��oG��}͜�0˴��(X�˸����F� 0��lb2-#X-�I��V4�K������D!���k%��ך9I����_<��u"H��!���^X����A����s8g�E���Ut FCkF���4��ȴ�5�.��e����c�rB�$d�r4�~�n13ܒ3,�ֶ/��T2�J�z�,֋��l������3:Y������y/�{��W���hm7:�@���8$[���	�t�,�}y&%;����!.w���<����H.H��m�r����b�a�YT8�p��j7U0��46��*g,!�;��5I�$��*456-� b���Bc c��`��4t9mjd�W�z<��p����u��W/`��pI���Ū�c�0�6XA�f��c�R�F	.+�<�������Y3
x	����"%'PH��E��x�u<��9�g�j��\+�k.m��ߩ��q΃�.�=����	B�P��˘V�="!_�����k�z8.�t�0S��KFB�f5ֳ��H
;(�Cr��g3iY��q�F��O��]~���z��h�*y����Z��-o�H��Z�6e(m*N�Q*"�*�
��H�"}�gJ����id��%-�}���0����1����m�^.�*'��i�4��>�s�/vt�?�H��     