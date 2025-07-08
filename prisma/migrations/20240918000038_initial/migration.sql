-- CreateTable
CREATE TABLE "tb_clients" (
    "id" SERIAL NOT NULL,
    "cpf" VARCHAR(14),
    "name" VARCHAR(255),
    "email" VARCHAR(255),

    CONSTRAINT "tb_clients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_items" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255),
    "type" VARCHAR(255),
    "price" DECIMAL(19,4),
    "quantity" DOUBLE PRECISION,
    "description" VARCHAR(255),
    "images" VARCHAR(1000),

    CONSTRAINT "tb_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_order_items" (
    "id" SERIAL NOT NULL,
    "order_id" BIGINT,
    "item_id" BIGINT,
    "quantity" DOUBLE PRECISION,
    "note" VARCHAR(255),
    "done" BOOLEAN,
    "orderId" INTEGER,
    "itemId" INTEGER,

    CONSTRAINT "tb_order_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_orders" (
    "id" SERIAL NOT NULL,
    "requester_id" BIGINT,
    "requested_at" TIMESTAMP(6),
    "updated_at" TIMESTAMP(6),
    "amount" DECIMAL(19,4),
    "status" VARCHAR(255),
    "payment_id" VARCHAR(255),
    "client_id" INTEGER,

    CONSTRAINT "tb_orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_payment_details" (
    "id" SERIAL NOT NULL,
    "payment_id" VARCHAR(255),
    "key" VARCHAR(255),
    "value" VARCHAR(255),

    CONSTRAINT "tb_payment_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_payments" (
    "id" VARCHAR(255) NOT NULL,
    "was_paid" BOOLEAN NOT NULL,
    "paid_at" TIMESTAMP(6),
    "method" VARCHAR(255),

    CONSTRAINT "tb_payments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_users" (
    "username" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255),
    "name" VARCHAR(255),
    "password" VARCHAR(255),
    "role" VARCHAR(255),

    CONSTRAINT "tb_users_pkey" PRIMARY KEY ("username")
);

-- CreateIndex
CREATE UNIQUE INDEX "tb_clients_cpf_key" ON "tb_clients"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "tb_payment_details_payment_id_key" ON "tb_payment_details"("payment_id");

-- CreateIndex
CREATE UNIQUE INDEX "tb_users_email_key" ON "tb_users"("email");

-- AddForeignKey
ALTER TABLE "tb_order_items" ADD CONSTRAINT "tb_order_items_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "tb_items"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_order_items" ADD CONSTRAINT "tb_order_items_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "tb_orders"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_orders" ADD CONSTRAINT "tb_orders_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "tb_clients"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_orders" ADD CONSTRAINT "tb_orders_payment_id_fkey" FOREIGN KEY ("payment_id") REFERENCES "tb_payments"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_payment_details" ADD CONSTRAINT "tb_payment_details_payment_id_fkey" FOREIGN KEY ("payment_id") REFERENCES "tb_payments"("id") ON DELETE SET NULL ON UPDATE CASCADE;
