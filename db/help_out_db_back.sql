PGDMP     &    $                y           help_out    12.3    12.3     %           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            &           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            '           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            (           1262    32777    help_out    DATABASE     �   CREATE DATABASE help_out WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'German_Germany.1252' LC_CTYPE = 'German_Germany.1252';
    DROP DATABASE help_out;
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
    "timestamp" timestamp with time zone,
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
       public         heap    postgres    false            !          0    32807    chat 
   TABLE DATA                 public          postgres    false    205   3                 0    32791    city 
   TABLE DATA                 public          postgres    false    203                    0    32786    gender 
   TABLE DATA                 public          postgres    false    202   �       "          0    32815    message 
   TABLE DATA                 public          postgres    false    206                     0    32799    user 
   TABLE DATA                 public          postgres    false    204   >       �
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
       public          postgres    false    2712    205    206            �
           2606    32828    user gid_fk    FK CONSTRAINT     t   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT gid_fk FOREIGN KEY (gid) REFERENCES public.gender(gid) NOT VALID;
 7   ALTER TABLE ONLY public."user" DROP CONSTRAINT gid_fk;
       public          postgres    false    202    2706    204            �
           2606    32838    chat username1_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username1_fk FOREIGN KEY (username1) REFERENCES public."user"(username) NOT VALID;
 ;   ALTER TABLE ONLY public.chat DROP CONSTRAINT username1_fk;
       public          postgres    false    205    204    2710            �
           2606    32843    chat username2_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat
    ADD CONSTRAINT username2_fk FOREIGN KEY (username2) REFERENCES public."user"(username) NOT VALID;
 ;   ALTER TABLE ONLY public.chat DROP CONSTRAINT username2_fk;
       public          postgres    false    2710    204    205            �
           2606    32833    user zip_fk    FK CONSTRAINT     z   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT zip_fk FOREIGN KEY (zipcode) REFERENCES public.city(zipcode) NOT VALID;
 7   ALTER TABLE ONLY public."user" DROP CONSTRAINT zip_fk;
       public          postgres    false    204    203    2708            !   �   x����
�0�w�"�$T�ҩC�X�m-'z��%��o�t��[\��!��;����I�ˑ<kxN�
4�}V^��+�`w�P
h1���v���Lf�<�Q��V\h��M���}�[/u���Z�o#��,�F��➆Eѵ�i%�)�ZZ��u�Z�RD���MY�r�2͘C̪�%�8�Nh=&��Ai�e-��B�f�����i�8�         w   x���v
Q���W((M��L�K�,�TШ�,H�OI�Q�K�M�Ts�	uV�0102�QP��̫R״��$Y�1e�M(�n
�R�X�G�~##C�����ʢ��t��03 9!<5���� �r         X   x���v
Q���W((M��L�KO�KI-R�H�L�Q�K�M�Ts�	uV�0�QP�u�qU״��$I�P��+yz��z�C<\�@Z�� {v2�      "   +  x���Qk�0���GhY-i�/nL�V���Qۋ�h�.I7d���A�R������%���i�d:DU�J���Iׄ^V���>�Y�ڐ�� �ݐME��)iIZ/�ϓż[]�y;��cĢ�φ�h���b6��%�v7�T�
����������ZI#h�?ІG��>j�	�1�}+3���d.��Rީ�̱Q5
*�qs�CzW�\K�/z|��+�����k)>����.�HX��	G�ժ$�`k���'�%�D�^�A�����x)I�� :�t�.x��j�  ���          �  x��V�n�0}�W}i+-�M�R
OEl�"Z���r�I�ۑ/-�{�~����V��k�V��8�}�9��z�����z�	��<��A}��"��\ۅ5�F�.��#��d�7�+9���#�ɛL����z&SO������5�*�*.-�}P���/C6E]��	��*f��eڌ�1�Y��W�0��n
WC��(�L<��$�� ���9X6ռ,��( |K#n-�x���&��߿:����q����6j��:�ɰP1ϕ�\��\��\�><}�̤����jVC�4� �A�r��5Ds������=ŋI�{:��*�:1_1�Rަ�gH����V�SJ�Z�Ј`���(g�AQZ&oYTj�vP7~��}��>�&��o����4�*%ضY��;3���ю�+�罂kZs�1��U	���KVbx)�'�hdtkP�7�pһ�!�T+[����
\J��},U΂@Ș��P���	��=��(Tg�����xk�$�,�h0�y���bв;��d�x.�e\�B9O��C�I/%�1�ƶ}���z��	妏�'��b�d#��\��2��r������5xr���l&����O��0���l��'�!�-V�3�}g=�$A
$���r�z�l?7/�@{\�k���~���mk7�{r�n*n�~Ԟ�V��\"5�
�y]�E��6uk�.���L�jB�C�T\4��MG_�� ��BS#3�
JZ�y���e�=��r98���:�     